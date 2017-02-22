
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
                     "1. PickerView2",
                     "2. PickerView3",
                     "3. PickerView4",
                     "4. DatePicker",
                     "5. PreWebView",
                     "6. Text",
                     "7. Form",
                     "8. FormButton",
                     "9. FormButtonScroll",
                     "10. Indicator",
                     "11. AddressBook",
                     "12. API",
                     "13. API2",
                     "14. O",
                     "15. P",
                     "16. Q",
                     "17. R",
                     "18. S",
                     "19. T",
                     "20. U",
                     "21. V",
                     "22. W",
                     "23. X",
                     "24. Y",
                     "25. Z"]

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
            second = PickerViewController2()
        case 2:
            second = PickerViewController3()
        case 3:
            second = PickerViewController4()
        case 4:
            second = DatePickerController()
        case 5:
            second = PreWebViewController()
        case 6:
            second = TextViewController()
        case 7:
            second = FormViewController()
        case 8:
            second = FormButtonViewController()
        case 9:
            second = FormButtonScrollViewController1()
        case 10:
            second = IndicatorViewController()
        case 11:
            second = AddressBookViewController()
        case 12:
            second = APIViewController()
        case 13:
            second = API2ViewController()
        case 14:
            second = O()
        case 15:
            second = P()
        case 16:
            second = Q()
        case 17:
            second = R()
        case 18:
            second = S()
        case 19:
            second = T()
        case 20:
            second = U()
        case 21:
            second = V()
        case 22:
            second = W()
        case 23:
            second = X()
        case 24:
            second = Y()
        case 25:
            second = Z()
        
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









