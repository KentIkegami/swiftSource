
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.

import UIKit
import Contacts
import ContactsUI

class AddressBookViewController: UIViewController, CNContactPickerDelegate
{
    var mailForm:UITextField!
    var nameForm:UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "連絡先アクセス"
        
        let customButton = CustomButton()
        let aaa = customButton.createButton(px: 100, py: 100, st: "選ぶ", ct:"", tag: 0)
        aaa.addTarget(self, action:  #selector(onTap(sender:)), for: .touchUpInside)
        self.view.addSubview(aaa)
        
        let customField = CustomField()
        //フォーム　mailAddress
        mailForm = customField.createField(px: 100, py: 200, st: "", ct: "デフォルト", tag: 0)
        self.view.addSubview(mailForm)
        //フォーム Name
        nameForm = customField.createField(px: 100, py: 300, st: "", ct: "でふぉると", tag: 1)
        self.view.addSubview(nameForm)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func onTap(sender: UIButton)
    {
       
        //連絡先アクセス
        let picker = CNContactPickerViewController()
        picker.delegate = self
        // 電話番号、メールアドレス、のみ表示する
        let displayedItems = [CNContactPhoneNumbersKey, CNContactEmailAddressesKey]
        picker.displayedPropertyKeys = displayedItems
        self.present(picker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        let property = contactProperty.value ?? ""//値
        let contact = contactProperty.contact
        let contactName = CNContactFormatter.string(from: contact, style: .fullName) ?? ""//なまえ
        let propertyName = CNContact.localizedString(forKey: contactProperty.key)//Email Phoneとか
        print(contactName)
        print(propertyName)
        print(property)
        
        if propertyName == "Email"
        {
            mailForm.text = "\(property)"
        }
        nameForm.text = contactName

    }
    

    
    
}
