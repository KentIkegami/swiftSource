//
//  Const.swift
//  magic
//
//  Created by kent on 2017/05/05.
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.
//

import Foundation

struct AppTitle {
    static let APPTITLE = "Gics"
}

/*管理者app イメージカラー*/
struct ColorAll
{
    static let COLOR_MAIN = "#4DCF68"  //みどり
    static let COLOR_BASE = "#000022"  //黒
    static let COLOR_ACCENT = "#F3B400"//おれんじ
    static let COLOR_FONT = "#FFFF22"  //黄色
    static let COLOR_FONT2 = "#FFFFFF"//しろ
    static let COLOR_MAIN_DARK = "#3a8c4b"//ハイライト緑
    static let COLOR_ACCENT_DARK = "#b2890e"//ハイライトおれんじ
}

/*web*/
struct WebUrl
{
    static let URL_RULE = "rule"
    static let URL_CREDIT = "credit"
    static let URL_LICENSE = "licence"
}

struct PrivateCharacteristicUUID
{
    static let WRITE_UUID = "7784863B-2261-4BFD-B82D-FDF6795505B3"  //スマホ/出荷管理アプリからBLE基板へデータを送信。
    static let INDICATE_UUID = "F04F849C-A170-47EE-B75F-B7FF49B24B9F"  //BLE基板からスマホ/出荷管理アプリへデータを送信。
}

