//
//  AccountTableVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/11.
//

import UIKit
import LeanCloud

class AccountTableVC: UITableViewController {
    
    var user: LCUser!
    
    var phoneNum: String? { user.mobilePhoneNumber?.value }
    var isSetPassword: Bool? { user.get(kIsSetPasswordCol)?.boolValue }
 
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var appleIDLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let phoneNum = phoneNum {
            phoneNumLabel.text = phoneNum
        }
        
        if let _ = isSetPassword{
            passwordLabel.text = "已设置"
        }
        
        if let authData = user.authData?.value{
            let keys = authData.keys
            if keys.contains("lc_apple"){
                appleIDLabel.text = user.getExactStringVal(col: kNickNameCol)
            }
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let passwordTableVC = segue.destination as? PasswordTableVC{
            passwordTableVC.user = user
            
            if isSetPassword == nil{
                passwordTableVC.setPasswordFinished = {
                    self.passwordLabel.text = "已设置"
                }
            }
            
            
        }
        
        
    }

}
