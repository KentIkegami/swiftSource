//  Copyright © 2017年 池上健仁. All rights reserved.
//

import Foundation
class DeserializeLogic
{
    
    var command: CUnsignedChar!
    var inputDataList: Array<[UInt8]> = []
    var mainKey:[UInt8]!
    var error:String = "no error"
    
    /*STL → スマホ*/
    func outputData() -> (Array<UInt8>, String)
    {
        var data:[UInt8] = []
        
        //チェックサムチェックとチェックサムデータのトリム
        for (i, _data) in inputDataList.enumerated()
        {
            //末尾のデータを抽出
            let endData:UInt8 = _data[_data.endIndex-1]
            
            //配列の先頭の値に次の値をXORしていく
            var checkSum:UInt8 = _data[0]
            //先頭と最後の値は除く
            for (i, _char) in _data.enumerated()
            {
                if i != 0 && i != _data.endIndex-1
                {
                    checkSum = checkSum ^ _char
                }
            }
            //チェックサムチェック
            if endData == checkSum
            {
                //チェックサムのトリム
                inputDataList[i].remove(at: inputDataList[i].endIndex-1)
            }
            else
            {
                error = "[ERROR] チェックサムエラー:\(i)|\(_data)"
                return (data, error)
            }
        }
        
        //データ長チェックとデータ長データのトリム、フラグメントのトリム
        for (i, _data) in inputDataList.enumerated()
        {
            //データ長チェック
            if Int(_data[0]) == _data.count
            {
                //データ長のトリム
                inputDataList[i].remove(at: 0)
                //フラグメントのトリム
                inputDataList[i].remove(at: inputDataList[i].endIndex-1)
            }
            else
            {
                error = "[ERROR] データ長エラー"
                return (data, error)
            }
        }
        
        
        //データの連結
        for _data in inputDataList
        {
            data += _data
        }
        
        //連結データのチェック
        print("複合前連結データ(\(data.count)):\(data)")
        
        //データの2次暗号複合
        var _mainKey:[UInt8] = self.mainKey
        var _outData:[UInt8] = []
        var _inData:[UInt8] = data
        let _dataSize = _inData.count
        let _outDataSize = Int(ceil(Double(Double(_dataSize)/16))*16)-16
        for _ in 1..._outDataSize
        {
            _outData.append(0x00)
        }
        
        //decrypt(&_outData, &_inData, _dataSize, &_mainKey)
        
        data = _outData
        
        print("複合後データ(\(data.count)):\(data)")
        //0詰めのトリム
        var valueSize = 100
        switch command {
        case 0x21:
            valueSize = 18
        case 0x23:
            valueSize = 3
        case 0x02:
            valueSize = 18
        case 0x06:
            valueSize = 2
        default:
            print("未定義")
        }
        
        var _data:[UInt8] = []
        for (i, _value) in data.enumerated()
        {
            if i == valueSize
            {
                data = _data
                break
            }
            _data.append(_value)
        }
        
        print("commandとチェックサム(0x21)(全体)を含む:\(data)")
        
        if command == 0x21 || command == 0x02
        {
            //チェックサムチェック(全体)とトリム
            //末尾のデータを抽出
            let endData:UInt8 = data[data.endIndex-1]
            
            //配列の先頭の値に次の値をXORしていく
            var checkSum:UInt8 = data[0]
            //先頭と最後の値は除く
            for (i, _char) in data.enumerated()
            {
                if i != 0 && i != data.endIndex-1
                {
                    checkSum = checkSum ^ _char
                }
            }
            //チェックサムチェック
            if endData == checkSum
            {
                //チェックサムのトリム
                data.remove(at: data.endIndex-1)
            }
            else
            {
                error = "[ERROR] チェックサムエラー(全体)"
                return (data, error)
            }
        }
        
        //コマンドのチェックとコマンドデータのトリム
        if data[0] == command
        {
            data.remove(at: 0)
        }
        else
        {
            error = "[ERROR] コマンドエラー"
            return (data, error)
        }
        
        
        //チェック
        //        for _data in inputDataList
        //        {
        //            print(" datacount:\(_data.count)|data: \(_data)")
        //        }
        //
        return (data, error)
    }
    
    
}

