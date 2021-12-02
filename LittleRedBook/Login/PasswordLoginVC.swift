//
//  PasswordLoginVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/22.
//

import UIKit
import LeanCloud

class PasswordLoginVC: UIViewController {
    
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var phoneNumStr: String { phoneNumTF.unwrappedText }
    var passwordStr: String { passwordTF.unwrappedText }

    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.setToDisabled()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        phoneNumTF.becomeFirstResponder()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func backToCodeLoginVC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func TFEditChanged(_ sender: Any) {
        if phoneNumStr.isPhoneNum && passwordStr.isPassword{
            loginBtn.setToEnabled()
        }else{
            loginBtn.setToDisabled()
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        view.endEditing(true)
        
        showLoadHUD()
        LCUser.logIn(mobilePhoneNumber: phoneNumStr, password: passwordStr) { result in
            
            switch result {
            case .success(object: let user):
                //登录成功跳转到个人页面
                self.dismissAndShowMeVC(user: user)
            case .failure(error: let error):
                self.hideLoadHUD()
                DispatchQueue.main.async {
                    //登录失败
                    self.showHUD(title: "登录失败", subTitle: error.reason, isCurrentView: true)
                }
            }
        }
    }
    
    
    
    
    
    
}


extension PasswordLoginVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let limit = textField == phoneNumTF ? 11 : 16
        let isExceed = range.location >= limit || (textField.unwrappedText.count + string.count) > limit
        if isExceed{
            showHUD(title: "最多只可以输入\(limit)位哦")
        }
        return !isExceed
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case phoneNumTF:
            passwordTF.becomeFirstResponder()
        default:
            if loginBtn.isEnabled{
                login(loginBtn)
            }
        }
        return true
    }
}
