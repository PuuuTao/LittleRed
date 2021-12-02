//
//  CodeLoginVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/22.
//

import UIKit
import LeanCloud

class CodeLoginVC: UIViewController {
    
    var timeRemain = kTotalTime
    
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var authCodeTF: UITextField!
    @IBOutlet weak var getAuthCodeBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    lazy var timer = Timer()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        loginBtn.setToDisabled()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        phoneNumTF.becomeFirstResponder()
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func TFEditingChanged(_ sender: UITextField) {
        if sender == phoneNumTF{
            getAuthCodeBtn.isHidden = !phoneNumTF.unwrappedText.isPhoneNum && getAuthCodeBtn.isEnabled
        }
        
        if phoneNumTF.unwrappedText.isPhoneNum && authCodeTF.unwrappedText.isAuthCode{
            loginBtn.setToEnabled()
        }else{
            loginBtn.setToDisabled()
        }
        
    }
    
    
    @IBAction func getAuthCode(_ sender: Any) {
        
        getAuthCodeBtn.isEnabled = false
        getAuthCodeBtn.setTitle("重新发送 \(timeRemain)s", for: .disabled)
        authCodeTF.becomeFirstResponder()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeAuthCodeBtnText), userInfo: nil, repeats: true)
        
        let variables: LCDictionary = [
            "name": LCString("LittlePink"),
            "ttl": LCNumber(10)
        ]

        LCSMSClient.requestShortMessage(
            mobilePhoneNumber: phoneNumTF.unwrappedText,
            //短信模版名字--需审核，待做
            templateName: kTemplateName,
            //短信签名名字--需审核，待做
            signatureName: kSignatureName,
            variables: variables)
        { (result) in
            switch result {
            case .success:
                break
            case .failure(error: let error):
                print(error)
            }
        }
        
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        view.endEditing(true)
        showLoadHUD()
        LCUser.signUpOrLogIn(mobilePhoneNumber: "+86\(phoneNumTF.unwrappedText)", verificationCode: authCodeTF.unwrappedText){ (result) in
            
            switch result {
            case .success(object: let user):
                //print(user)
                self.configAfterLogin(user: user)
                
            case .failure(error: let error):
                self.hideLoadHUD()
                self.showHUD(title: "登录失败", subTitle: error.reason, isCurrentView: true)
            }
        }
        
    }
    
}


extension CodeLoginVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let limit = textField == phoneNumTF ? 11 : 6
        let isExceed = range.location >= limit || (textField.unwrappedText.count + string.count) > limit
        if isExceed{
            showHUD(title: "最多只可以输入\(limit)位数字哦")
        }
        return !isExceed
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneNumTF{
            authCodeTF.becomeFirstResponder()
        }else{
            if loginBtn.isEnabled{
                login(loginBtn)
            }
        }
        return true
    }
    
    
}


extension CodeLoginVC{
    
    @objc func changeAuthCodeBtnText(){
        timeRemain -= 1
        getAuthCodeBtn.setTitle("重新发送 \(timeRemain)s", for: .disabled)
        
        if timeRemain <= 0{
            timer.invalidate()
            timeRemain = kTotalTime
            getAuthCodeBtn.isEnabled = true
            getAuthCodeBtn.setTitle("获取验证码", for: .normal)
            getAuthCodeBtn.isHidden = !phoneNumTF.unwrappedText.isPhoneNum
            
        }
        
        
    }
    
}
