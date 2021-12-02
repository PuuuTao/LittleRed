//
//  LoginVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/18.
//

import UIKit

class LoginVC: UIViewController {
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("登录", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = mainColor
        btn.layer.cornerRadius = 22
        btn.addTarget(self, action: #selector(login), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(loginBtn)
        setUI()
        
    }
    

    func setUI(){
        loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc func login(){
        #if targetEnvironment(simulator)
        //当前是模拟器
        presentCodeLoginVC()
        #else
        //当前是真机，继续使用本机号码一键登录
        localLogin()
        #endif
    }
    
    
}
