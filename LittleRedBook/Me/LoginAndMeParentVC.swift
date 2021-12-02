//
//  LoginAndMeParentVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/25.
//

import UIKit
import LeanCloud
 
var loginAndMeParentVC = UIViewController()
class LoginAndMeParentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = LCApplication.default.currentUser{
            let meVC = storyboard!.instantiateViewController(identifier: kMeVCID) { coder in
                MeVC(coder: coder, user: user)
            }
            add(childVC: meVC)
        }else{
            let loginVC = storyboard!.instantiateViewController(withIdentifier: kLoginVCID)
            add(childVC: loginVC)
        }
        
        loginAndMeParentVC = self
    }
    

    
}
