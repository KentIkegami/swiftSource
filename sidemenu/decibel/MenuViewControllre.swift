//
//  ViewController.swift
//  decibel
//
//  Created by inf on 2018/08/30.
//  Copyright © 2018年 kent. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    public var settingViewController = SettingViewController()
    public var aboutViewController = AboutViewController()
    //データ管理
    private var videos:[String] = ["1","2","3"]
    
    //GUI
    private var _tableView: UITableView!
    
    public var parentView:MainViewController!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brown
        self.tabelViewSet()//テーブルビューセット
        


        
    }
    
    
    /*-------------------------------------------------------------------------
     tabelView
     -------------------------------------------------------------------------*/
    func tabelViewSet(){
        if _tableView == nil{
            // TableView
            _tableView = UITableView(frame: CGRect(x: 0,
                                                   y: UIApplication.shared.statusBarFrame.size.height,
                                                   width: self.view.frame.width,
                                                   height: self.view.frame.height))
           // _tableView.register(nil,forCellReuseIdentifier: "SmallVideoCell")
            _tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            _tableView.dataSource = self//データソースの設定
            _tableView.delegate = self
            _tableView.tableFooterView = UIView(frame: .zero)
            _tableView.rowHeight = self.view.frame.width * 0.2
            self.view.addSubview(_tableView)
            
        }else{
            self._tableView.reloadData()
        }
    }
    

    /*Cellの総数を返す*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return videos.count
    }
    /*Cellに値を設定する*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = videos[indexPath.row]
        return cell
    }
    
    /*Cellが選択された際に呼び出される*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("Num: \(indexPath.row)")

        //parentView.aaa()
        parentView.addChildViewController(settingViewController)
        parentView.view.addSubview(settingViewController.view)
        settingViewController.didMove(toParentViewController: parentView)
    }

    
}

