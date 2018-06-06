class TemporaryKeyDataModel
{
    var temp_key_dataset:Array<UInt8>!   //一時鍵施解錠用一次データセット(一時鍵を暗号化したモノ)
    var article_dataset:Array<UInt8>!    //一時施解錠用一次データセット(物件識別IDを暗号化したモノ)
    var publish_id:Int!                //一時鍵発行id
    var temp_secret_key2:Array<UInt8>!   //一時鍵用二次暗号鍵
    var ble_uuid:String!               //管理モード用BLEのUUID
    var common_ble_uuid:String!           //共用部用BLEのUUID(2017/03/13追加)
    var article_id:Int!
    var article_name:String!
    var article_address:String!
    var start_datetime:String!
    var end_datetime:String!
    var publish_branch_name:String!
    
    var sent_message:String!
    
}
