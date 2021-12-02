//
//  MeVC-SettingOrChat.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/8.
//

import Foundation
import LeanCloud

extension MeVC{
    @objc func settingOrChat(){
        if isMySelf{
            //设置功能
            let settingTableVC = storyboard!.instantiateViewController(withIdentifier: kSettingTableVCID) as! SettingTableVC
            settingTableVC.user = user
            present(settingTableVC, animated: true)
        }else{
            if let _ = LCApplication.default.currentUser{
                //私信功能
            }else{
                showHUD(title: "请先登录哦")
            }
        }
    }
}
