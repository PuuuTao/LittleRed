//
//  LoginVC-localLogin.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/18.
//

import Foundation
import Alamofire

extension LoginVC{
    
     func localLogin(){
        
        showLoadHUD()
        
        let config = JVAuthConfig()
        config.appKey = kJAppKey
        config.authBlock = { _ in

            if JVERIFICATIONService.isSetupClient(){
                
                //预取号
                JVERIFICATIONService.preLogin(5000) { (result) in
                    
                    self.hideLoadHUD()
                    
                    if let result = result, let code = result["code"] as? Int, code == 7000{
                        
                        self.setLocalLoginUI()
                        self.presentLocalLoginVC()
                        
                    }else{
                        //print("预取号失败。错误码:\(result!["code"]), 错误描述：\(result!["content"])")
                        self.presentCodeLoginVC()
                        
                    }
                }
                
            }else{
                self.hideLoadHUD()
                print("初始化一键登录失败")
                self.presentCodeLoginVC()
            }
            
        }
        JVERIFICATIONService.setup(with: config)
    }
    
    
    
    //MARK: 弹出一键登录授权页+用户点击登录后
    func presentLocalLoginVC(){
        
        JVERIFICATIONService.getAuthorizationWith(self, hide: true, animated: true, timeout: 5*1000, completion: { (result) in
            if let result = result, let loginToken = result["loginToken"] as? String{
                
                JVERIFICATIONService.clearPreLoginCache()
                //self.getEncryptedPhoneNum(loginToken: loginToken)
                
                
            }else{
                print("一键登录失败")
                self.otherLogin()
            }
        }) { (type, content) in
            
            if let content = content {
                print("一键登录 actionBlock :type = \(type), content = \(content)")
            }
        }
        
        
    }
        
    }
    
    
    
//MARK: 一键登录页面UI
extension UIViewController{
    
    func setLocalLoginUI(){

        let config = JVUIConfig()
        
        let currentMode = UITraitCollection.current.userInterfaceStyle
        
        if currentMode == .dark{
            config.authPageBackgroundImage = UIImage(named: "black")
        }else if currentMode == .light{
            config.authPageBackgroundImage = UIImage(named: "white")
        }else{
            config.authPageBackgroundImage = UIImage(named: "white")
        }
        
        config.prefersStatusBarHidden = true
        
        config.navTransparent = true
        config.navText = NSAttributedString(string: " ")
        config.navReturnHidden = true
        config.navControl = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(dismissLocalLoginVC))
        
        if currentMode == .dark{
            config.logoImg = UIImage(named: "imagePH")
        }else if currentMode == .light{
            config.logoImg = UIImage(named: "imagePH-light")
        }else{
            config.logoImg = UIImage(named: "imagePH-light")
        }
        
        let logoWidth = kLogoImgWidth
        let logoHeight = kLogoImgHeight
        
        let ConstraintX = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let logoConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1/6, constant: 0)
        let logoConstraintH = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.none, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: logoHeight)
        let logoConstraintW = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.none, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: logoWidth)
        config.logoConstraints = [ConstraintX!, logoConstraintY!, logoConstraintW!, logoConstraintH!]
        
        let numberConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 100)
        config.numberConstraints = [ConstraintX!, numberConstraintY!]
        
        let sloganConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.number, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 35)
        config.sloganConstraints = [ConstraintX!, sloganConstraintY!]
        
        config.logBtnText = "同意协议并一键登录"
        config.logBtnImgs = [UIImage(named: "localLoginBtn-nor")!,
                             UIImage(named: "localLoginBtn-nor")!,
                             UIImage(named: "localLoginBtn-hig")!]
        
        let logBtnConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.slogan, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 50)
        config.logBtnConstraints = [ConstraintX!, logBtnConstraintY!]
        
        config.privacyState = true
        config.checkViewHidden = true
        
        config.appPrivacyOne = ["用户协议", "https://www.baidu.com"]
        config.appPrivacyTwo = ["隐私政策", "https://www.baidu.com"]
        config.privacyComponents = ["登录注册代表您已同意", "以及", "和", " "]
        config.appPrivacyColor = [UIColor.secondaryLabel, blueColor]
        config.privacyTextAlignment = .center
        let privacyConstraintW = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.none, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 260)
        let privacyConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -70)
        config.privacyConstraints = [ConstraintX!, privacyConstraintW!, privacyConstraintY!]
        
        
        config.agreementNavBackgroundColor = mainColor
        config.agreementNavReturnImage = UIImage(systemName: "chevron.left")
        
        
        JVERIFICATIONService.customUI(with: config){ customView in
            
            guard let customView = customView else { return }
            
            let otherLoginBtn = UIButton()
            otherLoginBtn.setTitle("其他方式登录", for: .normal)
            otherLoginBtn.setTitleColor(.secondaryLabel, for: .normal)
            otherLoginBtn.titleLabel?.font = .systemFont(ofSize: 15)
            otherLoginBtn.translatesAutoresizingMaskIntoConstraints = false
            otherLoginBtn.addTarget(self, action: #selector(self.otherLogin), for: .touchUpInside)
            
            customView.addSubview(otherLoginBtn)
            
            NSLayoutConstraint.activate([
                otherLoginBtn.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
                otherLoginBtn.centerYAnchor.constraint(equalTo: customView.centerYAnchor, constant: 220),
                otherLoginBtn.widthAnchor.constraint(equalToConstant: 279)
            ])
            
        }
    }
    
}
    

//MARK: 监听函数
extension UIViewController{
    
    @objc func dismissLocalLoginVC(){
        JVERIFICATIONService.dismissLoginController(animated: true, completion: nil)
    }
    
    @objc func otherLogin(){
        JVERIFICATIONService.dismissLoginController(animated: true) {
            self.presentCodeLoginVC()
        }
    }
    
}



//MARK: 一般函数
extension UIViewController{
    
    func presentCodeLoginVC(){
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNaviC = mainStoryboard.instantiateViewController(withIdentifier: kLoginNaviID)
        loginNaviC.modalPresentationStyle = .fullScreen
        present(loginNaviC, animated: true)
        
    }
    
}


//换取用户手机号的前端演示
extension UIViewController{
    
    func getEncryptedPhoneNum(loginToken: String){
        
        struct LocalLoginResult: Codable{
            let phone: String
        }
        
        let headers: HTTPHeaders = [
            .authorization(username: kJAppKey, password: "29bfd4c9d5f7320468f85b5f")
        ]
        
        let parameters = ["loginToken": loginToken]
        
        AF.request("https://api.verification.jpush.cn/v1/web/loginTokenVerify",
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: headers
        ).responseDecodable(of: LocalLoginResult.self) { response in
            
            if let localLoginResult = response.value{
                print(localLoginResult.phone)
            }
        }
        
        
    }
    
}
