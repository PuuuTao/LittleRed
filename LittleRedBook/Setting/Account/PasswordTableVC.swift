//
//  PasswordTableVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/11.
//

import UIKit
import LeanCloud

class PasswordTableVC: UITableViewController {

    var user: LCUser!
    var setPasswordFinished: (() -> ())?
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    
    var passwordStr: String{ passwordTF.unwrappedText }
    var newPasswordStr: String{ newPasswordTF.unwrappedText }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTF.becomeFirstResponder()
    }

    @IBAction func done(_ sender: UIButton) {
        if passwordStr.isPassword && newPasswordStr.isPassword{
            if passwordStr == newPasswordStr{
                
                user.password = LCString(passwordStr)
                try? user.set(kIsSetPasswordCol, value: true)
                user.save{ _ in }
                
                dismiss(animated: true)
                setPasswordFinished?()
                
            }else{
                showHUD(title: "两次密码不一致")
            }
        }else{
            showHUD(title: "密码必须为6-16位数字或字母")
        }
        
        
    }
    
    
    @IBAction func TFEditChanged(_ sender: Any) {
        if passwordTF.isBlank || newPasswordTF.isBlank{
            doneBtn.isEnabled = false
        }else{
            doneBtn.isEnabled = true
        }
    }
    
    
}

extension PasswordTableVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case passwordTF:
            newPasswordTF.becomeFirstResponder()
        default:
            if doneBtn.isEnabled{
                done(doneBtn)
            }
        }
        return true
    }
}
