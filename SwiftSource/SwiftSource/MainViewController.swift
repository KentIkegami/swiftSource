
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.


import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var pageTitle: NSArray!
    private var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        self.title = "MainView"
        
        pageTitle = ["0. PickerView",
                     "1. B",
                     "2. C",
                     "3. D",
                     "4. E",
                     "5. F"]

        //TableViewの生成
        myTableView = UITableView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: self.view.frame.width,
                                                height:self.view.frame.height))
        myTableView.backgroundColor = UIColor.yellow
        // Cell名の登録をおこなう
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        // DataSource、Delegateを自身に設定する.
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //選択状態のクリア
        if let indexPathForSelectedRow = myTableView.indexPathForSelectedRow {
            myTableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
     //Cellが選択された時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("index: \(indexPath.row) , value: \(pageTitle[indexPath.row])")
        
        var second:UIViewController!
        switch indexPath.row {
        case 0:
            second = PickerViewController()
        case 1:
            second = PickerViewController()
        case 2:
            second = PickerViewController()
        case 3:
            second = PickerViewController()
        case 4:
            second = PickerViewController()
        case 5:
            second = PickerViewController()
        default:
            print("遷移先が設定されていません。")
        }
        
        self.navigationController?.pushViewController(second, animated: true)
    }
    
    
     //Cellの総数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return pageTitle.count
    }
    

     //Cellに値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //Cellの再利用設定
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(pageTitle[indexPath.row])"
        
        return cell
    }
}









