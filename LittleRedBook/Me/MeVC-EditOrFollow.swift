//
//  MeVC-EditOrFollow.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/8.
//

import Foundation
import LeanCloud

extension MeVC{
    @objc func editOrFollow(){
        if isMySelf{
            //编辑资料
            let navi = storyboard!.instantiateViewController(withIdentifier: kEditProfileNaviID) as! UINavigationController
            navi.modalPresentationStyle = .fullScreen
            let editProfileTableVC = navi.topViewController as! EditProfileTableVC
            editProfileTableVC.user = user
            editProfileTableVC.delegate = self
            present(navi, animated: true)
        }else{
            if let _ = LCApplication.default.currentUser{
                //关注或取消关注功能
            }else{
                showHUD(title: "请先登录哦")
            }
        }
    }
}
