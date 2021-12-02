//
//  SocialLoginVC-Apple.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/21.
//

import Foundation
import AuthenticationServices
import LeanCloud

extension SocialLoginVC: ASAuthorizationControllerDelegate{
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential{
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userID = appleIDCredential.user
            var name = ""
            var email = ""
            if appleIDCredential.fullName?.familyName != nil || appleIDCredential.fullName?.givenName != nil{
                let familyName = appleIDCredential.fullName?.familyName ?? ""
                let givenName = appleIDCredential.fullName?.givenName ?? ""
                name = "\(givenName)\(familyName)"
                UserDefaults.standard.setValue(name, forKey: kNameFromAppleID)
                
            }else{
                name = UserDefaults.standard.string(forKey: kNameFromAppleID) ?? ""
                
            }
            
            if let unwrappedEmail = appleIDCredential.email{
                email = unwrappedEmail
                UserDefaults.standard.setValue(email, forKey: kEmailFromAppleID)
            }else{
                email = UserDefaults.standard.string(forKey: kEmailFromAppleID) ?? ""
            }
            
            guard let identityToken = appleIDCredential.identityToken,
                  let authorizationCode = appleIDCredential.authorizationCode else { return }
            
            //向LeanCloud发送苹果登录请求
            let appleData: [String: Any] = [
                // 必须
                "uid":             userID,
                // 可选
                "identity_token":  String(decoding: identityToken, as: UTF8.self),
                "code":            String(decoding: authorizationCode, as: UTF8.self)
            ]
            let user = LCUser()
            user.logIn(authData: appleData, platform: .apple) { (result) in
                switch result {
                case .success:
                    //assert(user.objectId != nil)
                    self.configAfterLogin(user: user, email: email)
                    
                case .failure(error: let error):
                    print(error)
                    self.showHUD(title: "登录失败", view: self.parent!.view, subTitle: error.reason)
                }
            }
            
        case let passwordCredential as ASPasswordCredential:
            print(passwordCredential)
        default:
            break
            
        }
        
    }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("苹果授权失败：\(error)")
    }
    
    
}


extension SocialLoginVC: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        view.window!
    }
}


extension SocialLoginVC{
    
    func checkSignInWithAppleState(userID: String){
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userID) { credentialState, error in
            switch credentialState{
                
            case .revoked:
                print("用户已经从设置中取消了苹果登录或者用了其他的appleID进行登录，展示应用的总登录页面")
            case .authorized:
                print("用户已登录，展示登录后的UI页面")
            case .notFound:
                print("无此用户，展示应用的总登录页面")
            default:
                break
            }
        }
    }
    
    
}
