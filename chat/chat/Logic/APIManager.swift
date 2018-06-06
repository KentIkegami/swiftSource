//  Copyright © 2016年 池上けんと. All rights reserved.
import Foundation

class APIManager
{
    var domain = "http://"
    
    private let extensionJson = ".json"
    
    //現在処理しているAPI
    private var apiName = "noApi"
    
    
    private var _limit = 0
    private var _publish_id = 0
    private var _language = 1
    private var _userid = ""
    private var _password = ""
    private var _token = ""
    private var _memo = ""
    private var _article_id = 0
    private var _start_datetime = ""
    private var _end_datetime = ""
    private var _email = ""
    private var _pin_code = "0000"
    private var _operation_datetime = ""
    private var _telephone_number = ""
    private var _stl_id:[UInt8] = []
    private var _resident_key:[UInt8] = []
    private var _rsdt_secret_key2:[UInt8] = []
    private var _smartphone_id:[UInt8] = []
    private var _change_device_id = ""
    private var _ble_uuid = ""
    private var _key_name = ""
    private var _mail_address = ""
    private var _shared_key_id = 0
    private var _change_device_pin_code = ""
    private var _change_device_code = ""
    private var _verify_dataset:[UInt8] = []
    private var _secret_key:[UInt8] = []
    
    //％エンコード
    let customEnc = CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]\"^|\\`{}<>\n").inverted
    
    //1.管理者アプリ用ログインAPI
    func setLogin(userid:String, password:String)
    {
        apiName = "login"
        _userid = userid.addingPercentEncoding(withAllowedCharacters: customEnc)!
        _password = password.addingPercentEncoding(withAllowedCharacters: customEnc)!
    }
    //1.5.管理者鍵発行情報取得API
    func setGetKeyInfo(token:String, language:Int)
    {
        apiName = "get-key-info"
        _token = token
        _language = language
    }
    
    
    //2. 管理者鍵取得API
    func setGet_management_key(token:String, publish_id:Int)
    {
        apiName = "get-management-key"
        _token = token
        _publish_id = publish_id
    }
    
    //3. 管理者アプリ用物件情報取得API
    func setGet_article_info(token:String, language:Int)
    {
        apiName = "get-article-info"
        _token = token
        _language = language
    }
    
    //4. 管理者鍵取得予約API
    func setManagement_key_request(token:String, article_id:Int, memo:String, start_datetime:String, end_datetime:String)
    {
        apiName = "request-management-key"
        _token = token
        _article_id = article_id
        _memo = memo.addingPercentEncoding(withAllowedCharacters: customEnc)!
        _start_datetime = start_datetime
        _end_datetime = end_datetime
    }
    
    //5. 一時鍵取得要求API
    func setRequest_temporary_key(email:String, pin_code:String, language:Int)
    {
        apiName = "request-temporary-key"
        _email = email.addingPercentEncoding(withAllowedCharacters: customEnc)!
        _pin_code = pin_code
        _language = language
    }
    
    //6. 動作履歴登録API
    func setRegist_history(publish_id:Int, operation_datetime:String)
    {
        apiName = "regist-history"
        _publish_id = publish_id
        _operation_datetime = operation_datetime
    }
    
    //7. 動作履歴取得API
    func setGet_history(token:String, language:Int, limit:Int)
    {
        apiName = "get-history"
        _token = token
        _language = language
        _limit = limit
    }
    
    //8. 認証状況確認API
    func setCheck_verification(telephone_number:String, pin_code:String)
    {
        apiName = "check-verification"
        _telephone_number = telephone_number.addingPercentEncoding(withAllowedCharacters: customEnc)!
        _pin_code = pin_code
    }
    
    //9. 切り替え鍵取得要求API
    func setGet_change_key(telephone_number:String, pin_code:String, language:Int)
    {
        apiName = "get-change-key"
        _telephone_number = telephone_number.addingPercentEncoding(withAllowedCharacters: customEnc)!
        _pin_code = pin_code
        _language = language
    }
    
    //10. 親機登録要求API
    func setRegist_parent(stl_id:Array<UInt8>, resident_key:Array<UInt8>, rsdt_secret_key2:Array<UInt8>, smartphone_id:Array<UInt8>, ble_uuid:String, telephone_number:String, verify_dataset:Array<UInt8>)
    {
        apiName = "regist-parent"
        _stl_id = stl_id
        _resident_key = resident_key
        _rsdt_secret_key2 = rsdt_secret_key2
        _smartphone_id = smartphone_id
        _ble_uuid = ble_uuid
        _telephone_number = telephone_number.addingPercentEncoding(withAllowedCharacters: customEnc)!
        _verify_dataset = verify_dataset
    }
    
    //11. 入居者鍵発行予約開始API
    func setCheck_parent(stl_id:Array<UInt8>, smartphone_id:Array<UInt8>)
    {
        apiName = "check-parent"
        _stl_id = stl_id
        _smartphone_id = smartphone_id
    }
    
    //12. 入居者鍵発行予約API
    func setShare_key(stl_id:Array<UInt8>,token:String, key_name:String, mail_address:String, start_datetime:String, end_datetime:String)
    {
        apiName = "share-key"
        _stl_id = stl_id
        _token = token
        _key_name = key_name.addingPercentEncoding(withAllowedCharacters: customEnc)!
        _mail_address = mail_address.addingPercentEncoding(withAllowedCharacters: customEnc)!
        _start_datetime = start_datetime
        _end_datetime = end_datetime
    }
    
    //13. 入居者鍵取得要求API
    func setGet_shared_key(mail_address:String, pin_code:String)
    {
        apiName = "get-shared-key"
        _mail_address = mail_address.addingPercentEncoding(withAllowedCharacters: customEnc)!
        _pin_code = pin_code
    }
    
    //14. 入居者鍵発行履歴取得要求API
    func setGet_shared_history(stl_id:Array<UInt8>, smartphone_id:Array<UInt8>)
    {
        apiName = "get-shared-history"
        _stl_id = stl_id
        _smartphone_id = smartphone_id
    }
    
    //15. 入居者鍵発行予約取消要求API
    func setCancel_shared_key(shared_key_id:Int)
    {
        apiName = "cancel-shared-key"
        _shared_key_id = shared_key_id
    }
    
    //16. 機種変更コード通知先メルアド確認API
    func setVerify_Mail(mail_address:String)
    {
        apiName = "verify-mail"
        _mail_address = mail_address
    }
    
    //17. 機種変更予約API
    func setReserve_change_device(stl_id:Array<UInt8>, change_device_id:String, smartphone_id:Array<UInt8>, mail_address:String, secret_key:Array<UInt8>)
    {
        apiName = "reserve-change-device"
        _stl_id = stl_id
        _change_device_id = change_device_id
        _smartphone_id = smartphone_id
        _mail_address = mail_address.addingPercentEncoding(withAllowedCharacters: customEnc)!
        _secret_key = secret_key
    }
    
    //18. 機種変更開始API
    func setChange_parent_device(change_device_id:String, pin_code:String)
    {
        apiName = "change-parent-device"
        _change_device_id = change_device_id
        _change_device_pin_code = pin_code
    }
    
    //19. 機種変更端末登録API
    func setRegist_changed_new_device(token:String,telephone_number:String, mail_address:String)
    {
        apiName = "regist-changed-new-device"
        _token = token
        _telephone_number = telephone_number.addingPercentEncoding(withAllowedCharacters: customEnc)!
        _mail_address = mail_address.addingPercentEncoding(withAllowedCharacters: customEnc)!
    }
    
    //20. 機種変更認証状況確認API
    func setCheck_change_verification(telephone_number:String, token:String)
    {
        apiName = "check-change-verification"
        _telephone_number = telephone_number.addingPercentEncoding(withAllowedCharacters: customEnc)!
        _token = token
    }
    
    //21. 機種変更入居者鍵取得要求API
    func setRequest_new_resident_key(token:String, telephone_number:String)
    {
        apiName = "request-new-resident-key"
        _token = token
        _telephone_number = telephone_number.addingPercentEncoding(withAllowedCharacters: customEnc)!
    }
    
    //22. 子鍵動作履歴登録API
    func setRegist_shared_key_used_history(shared_key_id:Int, operation_datetime:String)
    {
        apiName = "regist-shared-key-used-history"
        _shared_key_id = shared_key_id
        _operation_datetime = operation_datetime
    }
    
    //23. 子鍵動作履歴取得API
    func setGet_shared_key_used_history(stl_id:Array<UInt8>, smartphone_id:Array<UInt8>, limit:Int)
    {
        apiName = "get-shared-key-used-history"
        _stl_id = stl_id
        _smartphone_id = smartphone_id
        _limit = limit
    }
    
    
    
    
    func requestApi(callback:@escaping (String, NSDictionary) -> Void)
    {
        //シグナルチェック
        var _result = "yet"
        var _response: NSDictionary!
        
        //リクエスト作成
        let req = createReqest()
        
        //POSTリクエスト
        let task = URLSession.shared.dataTask(with: req as URLRequest){(data, response, error) in
            if data != nil
            {
                let OriginalData = String(data: data!, encoding: String.Encoding.utf8)!
                print(req)
                print(OriginalData)
                
                do
                {
                    //jsonデータの辞書型変換
                    _response = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    //resultの取り出し
                    if let _ = _response["result"]
                    {
                        _result = _response["result"] as! String
                    }
                    else
                    {
                        _result = "ERROR:NoResult"
                        _response = ["error": "リザルトが取得できませんでした。(code 0901)"]
                        print(error!)
                    }
                }
                catch
                {
                    _result = "ERROR:Serialize"
                    _response = ["error": "レスポンスデータが解析できませんでした。(code 0902)"]
                    print(error)
                }
            }
            else
            {
                _result = "ERROR:DataNull"
                _response = ["error": "ネットワーク接続が切れました。(code 0903)"]
                print(error!)
            }
            
            DispatchQueue.main.async{
                //let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(2.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                //DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                callback(_result, _response)
                //})
            }
        }
        task.resume()
    }
    
    //domain + APIname + .json
    private func createApiUrl()->URL
    {
        var apiStr:String = ""
        apiStr += domain
        apiStr += apiName
        apiStr += extensionJson
        
        return URL(string:apiStr)!
    }
    
    
    
    //リクエストの作成
    private func createReqest() -> NSMutableURLRequest
    {
        let req = NSMutableURLRequest(url: createApiUrl())
        req.httpMethod = "POST"
        
        var str = ""
        
        switch self.apiName
        {
        case "login":
            str += "app_code=smart_key&"
            str += "userid=\(_userid)&"
            str += "password=\(_password)"
            
        case "get-key-info":
            str += "app_code=smart_key&"
            str += "token=\(_token)&"
            str += "language=\(_language)"
            
        case "get-management-key":
            str += "app_code=smart_key&"
            str += "token=\(_token)&"
            str += "publish_id=\(_publish_id)"
            
        case "get-article-info":
            str += "app_code=smart_key&"
            str += "token=\(_token)&"
            str += "language=\(_language)"
            
        case "request-management-key":
            str += "app_code=smart_key&"
            str += "token=\(_token)&"
            str += "article_id=\(_article_id)&"
            str += "memo=\(_memo)&"
            str += "start_datetime=\(_start_datetime)&"
            str += "end_datetime=\(_end_datetime)"
            
        case "request-temporary-key":
            str += "app_code=smart_key&"
            str += "email=\(_email)&"
            str += "pin_code=\(_pin_code)&"
            str += "language=\(_language)"
            
        case "regist-history":
            str += "app_code=smart_key&"
            str += "publish_id=\(_publish_id)&"
            str += "operation_datetime=\(_operation_datetime)"
            
        case "get-history":
            str += "app_code=smart_key&"
            str += "token=\(_token)&"
            str += "language=\(_language)&"
            str += "limit=\(_limit)"
            
        case "check-verification":
            str += "app_code=smart_resident_key&"
            str += "telephone_number=\(_telephone_number)&"
            str += "pin_code=\(_pin_code)"
            
        case "get-change-key":
            str += "app_code=smart_resident_key&"
            str += "telephone_number=\(_telephone_number)&"
            str += "pin_code=\(_pin_code)&"
            str += "language=\(_language)"
            
        case "regist-parent":
            str += "app_code=smart_resident_key&"
            str += "stl_id=\(String(describing: _stl_id).replacingOccurrences(of: " ", with: ""))&"
            str += "resident_key=\(String(describing: _resident_key).replacingOccurrences(of: " ", with: ""))&"
            str += "rsdt_secret_key2=\(String(describing: _rsdt_secret_key2).replacingOccurrences(of: " ", with: ""))&"
            str += "smartphone_id=\(String(describing: _smartphone_id).replacingOccurrences(of: " ", with: ""))&"
            str += "ble_uuid=\(_ble_uuid)&"
            str += "telephone_number=\(_telephone_number)&"
            str += "verify_dataset=\(String(describing: _verify_dataset).replacingOccurrences(of: " ", with: ""))"
            
        case "check-parent":
            str += "app_code=smart_resident_key&"
            str += "stl_id=\(String(describing: _stl_id).replacingOccurrences(of: " ", with: ""))&"
            str += "smartphone_id=\(String(describing: _smartphone_id).replacingOccurrences(of: " ", with: ""))"
            
        case "share-key":
            str += "app_code=smart_resident_key&"
            str += "stl_id=\(String(describing: _stl_id).replacingOccurrences(of: " ", with: ""))&"
            str += "token=\(_token)&"
            str += "key_name=\(_key_name)&"
            str += "mail_address=\(_mail_address)&"
            str += "start_datetime=\(_start_datetime)&"
            str += "end_datetime=\(_end_datetime)"
            
        case "get-shared-key":
            str += "app_code=smart_resident_key&"
            str += "mail_address=\(_mail_address)&"
            str += "pin_code=\(_pin_code)"
            
        case "get-shared-history":
            str += "app_code=smart_resident_key&"
            str += "stl_id=\(String(describing: _stl_id).replacingOccurrences(of: " ", with: ""))&"
            str += "smartphone_id=\(String(describing: _smartphone_id).replacingOccurrences(of: " ", with: ""))"
            
        case "cancel-shared-key":
            str += "app_code=smart_resident_key&"
            str += "shared_key_id=\(_shared_key_id)"
            
        case "verify-mail":
            str += "app_code=smart_resident_key&"
            str += "mail_address=\(_mail_address)"
            
        case "reserve-change-device":
            str += "app_code=smart_resident_key&"
            str += "stl_id=\(String(describing: _stl_id).replacingOccurrences(of: " ", with: ""))&"
            str += "change_device_id=\(String(describing: _change_device_id).replacingOccurrences(of: " ", with: ""))&"
            str += "smartphone_id=\(String(describing: _smartphone_id).replacingOccurrences(of: " ", with: ""))&"
            str += "mail_address=\(_mail_address)&"
            str += "secret_key=\(String(describing: _secret_key).replacingOccurrences(of: " ", with: ""))"
            
        case "change-parent-device":
            str += "app_code=smart_resident_key&"
            str += "change_device_id=\(_change_device_id)&"
            str += "pin_code=\(_change_device_pin_code)"
            
        case "regist-changed-new-device":
            str += "app_code=smart_resident_key&"
            str += "token=\(_token)&"
            str += "telephone_number=\(_telephone_number)&"
            str += "mail_address=\(_mail_address)"
            
        case "check-change-verification":
            str += "app_code=smart_resident_key&"
            str += "telephone_number=\(_telephone_number)&"
            str += "token=\(_token)"
            
        case "request-new-resident-key":
            str += "app_code=smart_resident_key&"
            str += "token=\(_token)&"
            str += "telephone_number=\(_telephone_number)"
            
            
        case "regist-shared-key-used-history":
            str += "app_code=smart_resident_key&"
            str += "shared_key_id=\(_shared_key_id)&"
            str += "operation_datetime=\(_operation_datetime)"
            
        case "get-shared-key-used-history":
            str += "app_code=smart_resident_key&"
            str += "stl_id=\(String(describing: _stl_id).replacingOccurrences(of: " ", with: ""))&"
            str += "smartphone_id=\(String(describing: _smartphone_id).replacingOccurrences(of: " ", with: ""))&"
            str += "limit=\(_limit)"
            
        default:
            break
        }
        
        print("リクエストbody変換前str:"+str)
        let strData = str.data(using: String.Encoding.utf8)
        req.httpBody = strData
        
        return req
    }
    
    
    
}


