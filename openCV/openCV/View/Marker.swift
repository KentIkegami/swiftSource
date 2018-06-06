//
//  Marker.swift
//  Tech X mobile
//
//  Created by inf on 2017/12/12.
//  Copyright © 2017年 inf. All rights reserved.
//

import Foundation

class Marker{
    var ID:String! //マーカーのID
    var name:String! //マーカーの名前
    var comment:String! //マーカーのコメント
    var type:String! //マーカーのタイプ text / video / audio / image / web / mail / tel / multiple
    var imgdataUrl:String! //マーカーの画像URL
    var colId:String! //マーカーが登録されている対象のコレクションのID
}
