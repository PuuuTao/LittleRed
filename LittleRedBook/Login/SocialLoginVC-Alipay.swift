//
//  SocialLoginVC-Alipay.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/20.
//

import Foundation
import Alamofire

extension SocialLoginVC{
    
    func signInWithAlipay(){
        
        let infoStr = "apiname=com.alipay.account.auth&app_id=\(kAliPayAppID)&app_name=mc&auth_type=AUTHACCOUNT&biz_type=openservice&method=alipay.open.auth.sdk.code.get&pid=\(kAliPayPID)&product_id=APP_FAST_LOGIN&scope=kuaijie&sign_type=RSA2&target_id=20211020"
        
        guard let signer = APRSASigner(privateKey: kAlipayPrivateKey),
              let signedStr = signer.sign(infoStr, withRSA2: true) else { return }
        
        let authInfoStr = "\(infoStr)&sign=\(signedStr)"
        
        AlipaySDK.defaultService().auth_V2(withInfo: authInfoStr, fromScheme: kAppScheme){ res in
            
            guard let res = res else { return }
            let resultStatus = res["resultStatus"] as! String
            if resultStatus == "9000"{
                let resultStr = res["result"] as! String
                let resultArr = resultStr.components(separatedBy: "&")
                for subRes in resultArr{
                    let equalIndex = subRes.firstIndex(of: "=")!
                    let equalEndIndex = subRes.index(after: equalIndex)
                    let suffix = subRes[equalEndIndex...]
                    
                    if subRes.hasPrefix("auth_code"){
                        self.getToken(authCode: String(suffix))
                    }
                    
                }
                
            }else{
                print(resultStatus)
            }
        }
    }
}


extension SocialLoginVC {
    
    func getToken(authCode: String){
        
        let parameters = [
            "timestamp": Date().format(with: "yyyy-MM-dd HH:mm:ss"),
            "method": "alipay.system.oauth.token",
            "app_id": kAliPayAppID,
            "sign_type": "RSA2",
            "version": "1.0",
            "charset": "utf-8",
            "grant_type": "authorization_code",
            "code": authCode
        ]
        
        AF.request("https://openapi.alipay.com/gateway.do", parameters: self.signedParameters(parameters: parameters)).responseDecodable(of: TokenResponse.self) { response in
            
            if let tokenResponse = response.value{
                let accessToken = tokenResponse.alipay_system_oauth_token_response.access_token
                self.getInfo(accessToken: accessToken)
            }
        }
    }
    
    
    func getInfo(accessToken: String){
        
        let parameters = [
            "timestamp": Date().format(with: "yyyy-MM-dd HH:mm:ss"),
            "method": "alipay.user.info.share",
            "app_id": kAliPayAppID,
            "sign_type": "RSA2",
            "version": "1.0",
            "charset": "utf-8",
            "auth_token": accessToken
        ]
        AF.request("https://openapi.alipay.com/gateway.do", parameters: self.signedParameters(parameters: parameters)).responseDecodable(of: InfoShareResponse.self) { response in
            
            if let infoShareResponse = response.value{
                let info = infoShareResponse.alipay_user_info_share_response
                print(info.nickName)
            }
        }
    }
    
    
}


extension SocialLoginVC {
    
    func signedParameters(parameters: [String: String]) -> [String: String]{
        
        var signedParameters = parameters
        
        let urlParameters = signedParameters.map{"\($0)=\($1)"}.sorted().joined(separator: "&")
        guard let signer = APRSASigner(privateKey: kAlipayPrivateKey),
              let signedParaStr = signer.sign(urlParameters, withRSA2: true) else {
                  fatalError("加签失败")
              }
        signedParameters["sign"] = signedParaStr.removingPercentEncoding ?? signedParaStr
        return signedParameters
    }
    
}




extension SocialLoginVC {
    
    struct TokenResponse: Decodable{
        let alipay_system_oauth_token_response: TokenResponseInfo
        
        struct TokenResponseInfo: Decodable{
            let access_token: String
        }
    }
    
    
    struct InfoShareResponse: Decodable{
        let alipay_user_info_share_response: InfoShareResponseInfo
        
        struct InfoShareResponseInfo: Decodable{
            let avatar: String
            let nickName: String
            let gender: String
            let province: String
            let city: String
        }
    }
    
    
}
