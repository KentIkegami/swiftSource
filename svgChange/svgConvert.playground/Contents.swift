
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//[type, num, x, y, width, height, rotate]
/*type:8桁
ABCDEFGH
 A: 形状 1=長方形 2=丸 Rect or Ellipse
 B: 席判定 1=席 2=その他のオブジェクト
 CDE: 席番号 左0詰
 F: 未定義
 G: 未定義
 H: 未定義

 */

let seatArray:[Any] = []

/*ファイルの読み込み*/
let path = Bundle.main.path(forResource: "1", ofType: "svg")
let contents = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)

/*一行ずつ格納*/
let lines = contents.split(separator: "\n")

/*1行づつ解析*/
for (index, line) in lines.enumerated() {
    /*図形定義があったら処理*/
    if (line.contains("<g id=\"t_")){
        let l1 = line
        let l2 = lines[index + 1]
        //let seat:[String] = []
        print(l1)
        print(l2)
        /**/
        
        
    }

}



