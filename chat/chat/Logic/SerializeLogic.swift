//  Copyright © 2017年 池上健仁. All rights reserved.
//

import Foundation
class SerializeLogic
{
    
    var command: CUnsignedChar!
    var inputData: [UInt8]!
    var mainKey: [UInt8]!
    
    /*スマホ → STL*/
    func outputData() -> [NSData]
    {
        let intList = outputInt()
        var dataList:[NSData] = []
        
        for _data in intList
        {
            dataList.append(NSData(bytes: _data, length: _data.count))
        }
        
        return dataList
        
    }
    
    
    
    func outputInt() -> Array<[UInt8]>
    {
        /*データベースからBLE　UInt8 → CUnsignedCharList*/
        var dataList:[[UInt8]] = []
        var dataBuffer:[UInt8] = []
        
        //コマンド
        let command :CUnsignedChar = self.command
        dataBuffer.append(command)
        
        //一次暗号済みデータ
        let dbValue:[UInt8] = self.inputData
        dataBuffer += dbValue
        
        //チェックサム
        //配列の先頭の値に次の値をXORしていく
        var checkSum:UInt8 = dataBuffer[0]
        for (i, _char) in dataBuffer.enumerated()
        {
            if i != 0
            {
                checkSum = checkSum ^ _char
            }
        }
        //チェックサムを末尾に付加
        dataBuffer.append(checkSum)
        
        
        //2時暗号化暗号化
        print("暗号化前\(dataBuffer.count):\(dataBuffer)")
        var mainKey:[UInt8] = self.mainKey
        var outData:[UInt8] = []
        var inData:[UInt8] = dataBuffer
        let dataSize = inData.count
        let outDataSize = Int(ceil(Double(Double(dataSize)/16))*16)+16
        for _ in 1...outDataSize
        {
            outData.append(0x00)
        }
        
        //_encrypt(&outData, &inData, dataSize, &mainKey)
        dataBuffer = outData
        print("暗号化後\(dataBuffer.count):\(dataBuffer)")
        
        
        //17byteごとに区切る
        var data:[UInt8] = []
        for (i, _value) in dataBuffer.enumerated()
        {
            data.append(_value)
            
            if (i + 1) % 17 == 0 || i + 1 == dataBuffer.count
            {
                dataList.append(data)
                data = []
            }
        }
        
        //フラグメントとデータ長の付加。フラグメントは01で継続 00が終了　データ長はデータ.count + 2(フラグメントとチェックサムの分)
        for (i, _data) in dataList.enumerated()
        {
            //データ長の追加
            let dataLength = _data.count + 2
            dataList[i].insert(UInt8(dataLength), at: 0)
            
            var fragment = 1
            //フラグメントの追加
            if i == dataList.count - 1
            {
                fragment = 0
            }
            
            dataList[i].append(UInt8(fragment))
        }
        
        //チェックサム付加
        for (i, _data) in dataList.enumerated()
        {
            //配列の先頭の値に次の値をXORしていく
            var checkSum:UInt8 = _data[0]
            for (i, _char) in _data.enumerated()
            {
                if i != 0
                {
                    checkSum = checkSum ^ _char
                }
            }
            //チェックサムを末尾に付加
            dataList[i].append(checkSum)
        }
        
        //チェック
        for _data in dataList
        {
            print(" datacount:\(_data.count)|data: \(_data)")
        }
        return dataList
    }
    
    
    
}

