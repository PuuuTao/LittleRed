//
//  Login-Extensions.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/25.
//

import Foundation
import LeanCloud

extension UIViewController{
    
    func configAfterLogin(user: LCUser, email: String = ""){
        
        if let _ = user.get(kNickNameCol){
            //非首次登录
            dismissAndShowMeVC(user: user)
        }else{
            
            let group = DispatchGroup()
            
            //首次登录
            let randomNickName = "小红薯\(String.randomString(length: 6))"
            let randomAvatar = UIImage(named: "avatarPH\(Int.random(in: 1...4))")!
            
            do {
                if email != ""{
                    user.email = LCString(email)
                }
                
                try user.set(kNickNameCol, value: randomNickName)
                
            } catch {
                print("给字段赋值失败，原因是：\(error)")
                return
            }
            
            group.enter()
            user.save { _ in
                group.leave()
            }
            
            if let avatarData = randomAvatar.pngData(){
                let avatarFile = LCFile(payload: .data(data: avatarData))
                avatarFile.mimeType = "image/jpeg"
                
                avatarFile.save(record: kAvatarCol, table: user, group: group)
                
            }
            
            group.enter()
            let userInfo = LCObject(className: kUserInfoTable)
            try? userInfo.set(kUserObjectidCol, value: user.objectId)
            userInfo.save { _ in group.leave() }
            
            group.notify(queue: .main) {
                self.dismissAndShowMeVC(user: user)
            }
        }
    }
    
    
    func dismissAndShowMeVC(user: LCUser){
        hideLoadHUD()
        
        DispatchQueue.main.async {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let meVC = mainStoryboard.instantiateViewController(identifier: kMeVCID) { coder in
                MeVC(coder: coder, user: user)
            }
            loginAndMeParentVC.removeChildren()
            loginAndMeParentVC.add(childVC: meVC)
            
            self.dismiss(animated: true)
        }
    }
    
    
    
}
