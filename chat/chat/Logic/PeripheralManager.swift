//  Copyright © 2016年 池上けんと. All rights reserved.
import Foundation
import CoreBluetooth

protocol BTPeripheralDelegate {
    func message(s: String)
    func debug(s: String)
}

class BTPeripheral: NSObject, CBPeripheralManagerDelegate {
    let servUuid = CBUUID(string: "SSSSSSSS-4AE3-4E44-92D9-64688AD8D6FB")
    let writeUuid = CBUUID(string: "11111111-F3DC-48C9-BD8C-4394434A21C0")
    let readUuid = CBUUID(string: "22222222-F3DC-48C9-BD8C-4394434A21C0")
    let manager: CBPeripheralManager
    let delegate: BTPeripheralDelegate
    
    

    
    /*---------------------------------------------------------------------*/
    //必須メソッド
    /*---------------------------------------------------------------------*/
    init(delegate: BTPeripheralDelegate) {
        manager = CBPeripheralManager(delegate: nil, queue: nil, options: nil)
        self.delegate = delegate
        super.init()
        manager.delegate = self
    }
    
    //状態変化したらよばれる
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        switch (peripheral.state)
        {
        case .poweredOn:
            //writeサービスを追加
            manager.add(settingWriteService())
            //readサービスを追加
            
            print("[BLE<private>] 0101 CentralManagerState:BlueTooth電源on" )
        case .poweredOff:
            print("[BLE<private>] 0102 CentralManagerState:BlueToothの電源がOff")
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
    
    //アドバタイズスタートしたらよばれる。
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: Error?,_: Error?) {
        if let e = error {
            delegate.debug(s: "ERROR: \(e)")
        } else {
            delegate.debug(s: "advertise started")
        }
    }
    
    /*---------------------------------------------------------------------*/
    //公開メソッド
    /*---------------------------------------------------------------------*/
    //アドバタイズスタート
    public func startAdvertising() {
        let data: [String : Any] = [CBAdvertisementDataServiceUUIDsKey: [servUuid],//サービスUUIDの指定
            CBAdvertisementDataLocalNameKey: "test"]//サービス名の設定
        manager.startAdvertising(data)
    }
    //アドバタイズストップ
    public func stopAdvertising() {
        manager.stopAdvertising()
    }
    
    /*---------------------------------------------------------------------*/
    //write
    /*---------------------------------------------------------------------*/
    //writeサービスの設定
    private func settingWriteService() -> CBMutableService{
        let characteristic = CBMutableCharacteristic( //キャラクタリスティック指定
            type: writeUuid,
            properties: .write,
            value: nil,
            permissions: .writeable)
        
        let service = CBMutableService(type: servUuid, primary: true)
        service.characteristics = [characteristic]
        
        return service
    }

    
    func peripheralManager(peripheral: CBPeripheralManager, didReceiveWriteRequests requests: [CBATTRequest]) {
        let req = requests.first!
        let s = NSString(data: req.value!, encoding: String.Encoding.utf8.rawValue)!//String.Encoding.utf8String.Encoding.utf8.rawValue)!
        delegate.message(s: s as String)
        manager.respond(to: req, withResult: .success)
        
        print(s)
    }
    
    /*---------------------------------------------------------------------*/
    //read
    /*---------------------------------------------------------------------*/
    
}
