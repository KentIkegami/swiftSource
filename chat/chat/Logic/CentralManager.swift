//  Copyright © 2016年 池上けんと. All rights reserved.
import Foundation
import CoreBluetooth

class CentralManager :
    NSObject,
    CBCentralManagerDelegate,
    CBPeripheralDelegate
{
    //BLEメンバ変数
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    var targetPeripheralsUUIDs: [CBUUID] = []
    var s:Int = 0
    
    var _timeOutTimer: Timer!
    var _intervalTimer: Timer!
    
    //認証NONCE値
    var nonceHash: [UInt8]!
    
    //選択されている物件情報
    var selectedKeys: TemporaryKeyDataModel!
    
    //インスタンス
    let serializeLogic = SerializeLogic()
    let deserializeLogic = DeserializeLogic()
    
    func initBLE(unlockServiceUUID: String)
    {
        //シーケンスナンバー初期化
        s = 1
        //ターゲットペリフェラル(サービスの指定)
        targetPeripheralsUUIDs = []
        targetPeripheralsUUIDs.append(CBUUID(string: unlockServiceUUID))
        
        // セントラルマネージャ初期化
        centralManager = CBCentralManager(delegate: self,
                                          queue: nil)
    }
    
    //0100 セントラルマネージャの状態が変化すると呼ばれる → 0200
    func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        switch (central.state)
        {
        case .poweredOn:
            // BLEデバイスの検出を開始.
            print("[BLE<private>] 0101 CentralManagerState:スキャン開始 対象UUIDs[\(targetPeripheralsUUIDs)]")
            centralManager.scanForPeripherals(withServices: targetPeripheralsUUIDs,
                                              options: nil)
        case .poweredOff:
            print("[BLE<private>] 0102 CentralManagerState:Bluetoothの電源がOff")
        case .resetting:
            print("[BLE<private>] 0103 CentralManagerState:レスティング状態")
        case .unauthorized:
            print("[BLE<private>] 0104 CentralManagerState:非認証状態")
        case .unknown:
            print("[BLE<private>] 0105 CentralManagerState:不明")
        case .unsupported:
            print("[BLE<private>] 0106 CentralManagerState:非対応")
        }
    }
    
    //0200 周辺にあるデバイスを発見すると呼ばれる → 0300
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber)
    {
        print("[BLE<private>] 0201 Discover Peripheral:\(peripheral)")
        //ペリフェラルとコネクト
        self.peripheral = peripheral
        self.centralManager.connect(self.peripheral,
                                    options: nil)
    }
    
    //0300 ペリフェラルへの接続が成功するとよばれる → 0400
    func centralManager(_ central: CBCentralManager,
                        didConnect peripheral: CBPeripheral)
    {
        print("[BLE<private>] 0301 Connected to Peripheral")
        
        //スキャンの停止
        scanStop()
        
        peripheral.delegate = self
        //サービスの探索開始([UUID] or nil→ALL)
        peripheral.discoverServices(targetPeripheralsUUIDs)
    }
    
    //0300 ペリフェラルへの接続が失敗するとよばれる
    func centralManager(_ central: CBCentralManager,
                        didFailToConnect peripheral: CBPeripheral,
                        error: Error?)
    {
        print("[BLE<private>] 0302 Connection Failure|error:\(String(describing: error))")
    }
    
    //0400 サービスの探索結果を受け取る → 0500
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverServices error: Error?)
    {
        guard error == nil else
        {
            print("[BLE<private>] 0402 didDiscoverServices　error:\(String(describing: error))")
            return
        }
        
        let services = peripheral.services
        
        if services?.count != 0
        {
            for (i, _service) in services!.enumerated()
            {
                print("[BLE<private>] 0401 サービス(\(i)):\(_service)")
            }
            
            // BLEモジュールが単一のサービスのみを実施中であることを前提とした実装
            assert(services?.count == 1)
            print("[BLE<private>]    ∟ Current Target Service UUID: \(String(describing: services?[0].uuid))")
            
            //特定のキャラスタリスティック探索
            characteristicSelector(eventNumber:s)
        }
        else
        {
            print( "[BLE<private>] 0402 no servise")
        }
    }
    
    //0500 特性別シーケンス → 0600
    func characteristicSelector(eventNumber:Int)
    {
        print("[BLE<private>] 0500 eventNumber:\(eventNumber)")
        let services = peripheral.services
        
        //timeout設定
        timerResetter(timeInterval: 100)
        
        switch eventNumber
        {
        //NONCE認証応答(indicate)//施解錠動作通知(indicate)
        case 1:
            for obj in services!
            {
                peripheral.discoverCharacteristics([CBUUID(string:PrivateCharacteristicUUID.INDICATE_UUID)],
                                                   for: obj)
                print("[BLE<private>] 0501 キャラ探索:NONCE取得応答/施解錠動作応答|INDICATE|)")
            }
        //NONCE認証要求(write)
        case 2:
            for obj in services!
            {
                peripheral.discoverCharacteristics([CBUUID(string:PrivateCharacteristicUUID.WRITE_UUID)],
                                                   for: obj)
                print("[BLE<private>] 0502 キャラ探索:NONCE取得要求|WRITE|)")
            }
        //施解錠動作要求(write)
        case 3:
            for obj in services!
            {
                peripheral.discoverCharacteristics([CBUUID(string:PrivateCharacteristicUUID.WRITE_UUID)],
                                                   for: obj)
                print("[BLE<private>] 0503 キャラ探索:施解錠動作要求|WRITE|)")
            }
        default:
            print("[BLE<private>] 0509 default")
            s = 0
        }
    }
    
    
    //0600 キャラスタリスティックの探索結果を受け取る
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverCharacteristicsFor service: CBService,
                    error: Error?)
    {
        guard error == nil else
        {
            print("[BLE<private>] 0609 didDiscoverCharacteristicsFor　error:\(String(describing: error))")
            return
        }
        
        var characteristics = service.characteristics
        
        for _chara in characteristics!
        {
            print("[BLE<private>] 0600 キャラ発見: \(_chara))")
            
            switch s
            {
            case 1:// → 0700
                if _chara.uuid.isEqual(CBUUID(string: PrivateCharacteristicUUID.INDICATE_UUID))
                {
                    print("[BLE<private>] 0601 Notify設置:NONCE認証応答/施解錠動作応答|INDICATE|)")
                    peripheral.setNotifyValue(true,for: _chara)
                    
                }
            case 2:// → 0800
                if _chara.uuid.isEqual(CBUUID(string: PrivateCharacteristicUUID.WRITE_UUID))
                {
                    print("[BLE<private>] 0602 書き込み実施:NONCE認証要求|WRITE|)")
                    let dataList: [NSData] = createDataList(command:0x20)
                    writeDataList = dataList
                    writeCharacteristic = _chara
                    writeValue()
                }
                
            case 3:
                if _chara.uuid.isEqual(CBUUID(string: PrivateCharacteristicUUID.WRITE_UUID))
                {
                    print("[BLE<private>] 0603 書き込み実施:施解錠動作要求|WRITE|)")
                    let dataList: [NSData] = createDataList(command:0x22)
                    writeDataList = dataList
                    writeCharacteristic = _chara
                    writeValue()
                }
            default:
                print("[BLE<private>] 0609 default")
            }
        }
        characteristics = []
    }
    
    /*-------------------------------------------------------------------------
     indicate 0700
     -------------------------------------------------------------------------*/
    //notify設定時に入る
    func peripheral(_ peripheral: CBPeripheral,
                    didUpdateNotificationStateFor characteristic: CBCharacteristic,
                    error: Error?)
    {
        guard error == nil else
        {
            print("[BLE<private>] 0700 didUpdateNotificationStateFor　error:\(String(describing: error))")
            return
        }
        
        switch s {
        case 1:
            print("[BLE<private>] 0701 Notify Setting Success")
            
            s = 2
            characteristicSelector(eventNumber:s)
        default:
            print("[BLE<private>] 0709 default")
        }
        
    }
    
    
    
    //読み出したデータ
    var readDataList:[[UInt8]] = []
    //データの読み出し結果を取得する。
    func peripheral(_ peripheral: CBPeripheral,
                    didUpdateValueFor characteristic: CBCharacteristic,
                    error: Error?)
    {
        guard error == nil else
        {
            print("[BLE<private>] 0900 didUpdateValueFor　error:\(String(describing: error))")
            return
        }
        
        print("[BLE<private>] 0900 Data Read Success|uuid:\(characteristic.uuid)|data:\(characteristic.value)")
        
        //フラグメントチェック
        var fragment:UInt8 = 0
        // 文字列からNSDataインスタンスを作る。
        if let aData: NSData = characteristic.value as NSData?
        {
            // aDataのバイト数と同じ大きさの配列を作る。(暗号ロジックに合わせ、符号なし整数型で受ける)
            var aBuffer = Array<UInt8>(repeating: 0,
                                       count: aData.length)
            // aBufferにバイナリデータを格納。
            aData.getBytes(&aBuffer,
                           length: aData.length) // &がアドレス演算子みたいに使える。
            
            
            var UIntList:[UInt8] = []
            ////255 ~ 128 ~ 127 ~ 0 : -1 ~ -128 ~ 127 ~ 0
            for _aChar in aBuffer
            {
                UIntList.append(_aChar)
            }
            fragment = UIntList[UIntList.endIndex-2]
            print(UIntList)
            readDataList.append(UIntList)
        }
        
        //データのフラグメントにより切り分け
        if fragment == 0
        {
            print("[BLE<private>] Indication End")
            
            switch s {
            case 2:
                deserializeLogic.command = 0x21
            case 3:
                deserializeLogic.command = 0x23
            default:
                print("[BLE<private>] 未定義")
            }
            
            //複合し、NONCE値を取り出す
            deserializeLogic.inputDataList = readDataList
            deserializeLogic.mainKey = selectedKeys.temp_secret_key2
            let deserializedDataTuple = deserializeLogic.outputData()
            
            guard deserializedDataTuple.1 == "no error" else
            {
                //エラー終了
                print("[BLE<private>] 0000 \(deserializedDataTuple.1)")
                //コネクションを切る
                cancelConection()
                return
            }
            
            print(deserializedDataTuple.0)
            switch s {
            case 2:
                //認証NONCE値のセット
                self.nonceHash = createHash(nonceValue:deserializedDataTuple.0, command:0x22)
                //ステータスを進める
                s = 3
                characteristicSelector(eventNumber: s)
            case 3:
                //タイマー削除
                dismissTimer()
                
                //tupleの値で処理切り分け
                s = 4
                switch deserializedDataTuple.0[0] {
                case 0 :
                    s = 4
                case 1 :
                    s = 3
                default:
                    s = 3
                }
                
                
                //コネクションを切る
                cancelConection()
            default:
                print("[BLE<private>] 未定義")
            }
            
            //値のリセット
            readDataList = []
        }
        
    }
    
    private func createHash(nonceValue:[UInt8], command:CUnsignedChar) -> [UInt8]
    {
        let _cmnd:UInt8 = UInt8(command)
        var _nonceHash:[UInt8] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        var _nonce = nonceValue
        //createHashValue(_cmnd, &_nonce, &_nonceHash)
        
        print("ハッシュ化前\(nonceValue)")
        print("nonceHash:\(_nonceHash)")
        
        return _nonceHash
    }
    
    /*-------------------------------------------------------------------------
     write 0800
     -------------------------------------------------------------------------*/
    //書き込み件数保持
    var writeState:Int = 0
    //書き込み分割データ
    var writeDataList:[NSData]!
    //write対象
    var writeCharacteristic:CBCharacteristic!
    
    //データの整形処理
    func createDataList(command:CUnsignedChar) -> [NSData]
    {
        switch command {
        case 0x20:
            serializeLogic.command = 0x20
            serializeLogic.mainKey = selectedKeys.temp_secret_key2
            serializeLogic.inputData = selectedKeys.article_dataset
        case 0x22:
            serializeLogic.command = 0x22
            serializeLogic.mainKey = selectedKeys.temp_secret_key2
            serializeLogic.inputData = nonceHash + selectedKeys.temp_key_dataset
            
        default:
            print("[BLE<private>] 未定義")
        }
        
        //データ成形
        let dataList = serializeLogic.outputData()
        return dataList
    }
    
    
    //データの書き込み処理
    func writeValue()
    {
        print("[BLE<private>] 0800 writeData:\(writeDataList[writeState])")
        if peripheral != nil
        {
            peripheral.writeValue(writeDataList[writeState] as Data,
                                  for: writeCharacteristic,
                                  type: CBCharacteristicWriteType.withResponse)
        }
        
    }
    
    //データの書き込み結果を取得する
    func peripheral(_ peripheral: CBPeripheral,
                    didWriteValueFor characteristic: CBCharacteristic,
                    error: Error?)
    {
        guard error == nil else
        {
            print("[BLE<private>] 0800 didWriteValueFor　error:\(error)")
            return
        }
        print("[BLE<private>] 0801 書き込み成功")
        
        
        if writeState != writeDataList.count - 1
        {
            writeState += 1
            self.writeValue()
        }
        else
        {
            //データ読み取りのリストの初期化
            readDataList = []
            
            writeState = 0
        }
        
    }
    
    
    /*-------------------------------------------------------------------------
     timer 8000
     -------------------------------------------------------------------------*/
    //タイマーのリセッター
    func timerResetter(timeInterval:TimeInterval)
    {
        if _timeOutTimer == nil
        {
            print("[BLE<private>] 8001 timeOutTimer Start! limitTime(\(timeInterval))")
        }
        else
        {
            _timeOutTimer.invalidate()
            _timeOutTimer = nil
            
            print("[BLE<private>] 8002 timeOutTimer ReStart! limitTime(\(timeInterval))")
        }
        
//        _timeOutTimer = Timer.scheduledTimer(timeInterval: timeInterval,
//                                             target: self,
//                                             selector: #selector(self.waitUnlockNotifyTimeout(_:)),
//                                             userInfo: nil,
//                                             repeats: false)
    }
    
    // 解錠（ドアノブ動作）の動作タイムアウトコールバック
    func waitUnlockNotifyTimeout(_ timer : Timer)
    {
        print("[BLE<private>] 8002 錠動作通知取得タイムアウト！")
        cancelConection()
    }
    
    //定期チェック
    func intervalCall(_ timer: Timer)
    {
        if peripheral != nil
        {
            peripheral.readRSSI()
        }
        
    }
    
    //リードRSSI実行時に入る
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        print("[BLE<private>] 8003 peripheral:\(peripheral)|RSSI:\(RSSI)|error:\(error)")
        
    }
    
    //timerの削除
    func dismissTimer()
    {
        if _timeOutTimer != nil
        {
            _timeOutTimer.invalidate()
            _timeOutTimer = nil
        }
        
        if _intervalTimer != nil
        {
            _intervalTimer.invalidate()
            _intervalTimer = nil
        }
    }
    
    /*-------------------------------------------------------------------------
     cancel stop Disconnect 9000
     -------------------------------------------------------------------------*/
    
    //スキャンを明示的に止める
    func scanStop()
    {
        if self.centralManager != nil
        {
            self.centralManager.stopScan()
            print("[BLE<private>] 9001 Stop Scan")
        }
        
        dismissTimer()
        
    }
    
    //コネクションを切る
    func cancelConection()
    {
        if self.peripheral != nil
        {
            self.centralManager.cancelPeripheralConnection(self.peripheral)
            print("[BLE<private>] 9002 Try to Disconnect")
        }
        
        dismissTimer()
    }
    
    // デバッグ用切断時出力 By 小河
    func centralManager(_ central: CBCentralManager,
                        didDisconnectPeripheral peripheral: CBPeripheral,
                        error: Error?)
    {
        //_timeOutTimer.invalidate()
        print("[BLE<private>] 9003 Disconnected from Peripheral|error:\(error)")
        
        if (s == 4)
        {
            // 解錠シーケンス正常終了
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "privateSequenceFinished"),
                                            object: nil)
        }
        else
        {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "privateSequenceFinishedAbnormally"),
                                            object: nil)
        }
    }
    
    
}








