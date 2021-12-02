//
//  MeVC-Delegate.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/10.
//

import Foundation
import LeanCloud

extension MeVC: EditProfileTableVCDelegate{
    func updateUser(avatar: UIImage?, nickName: String, gender: Bool, birth: Date?, intro: String) {
        
        //头像
        if let avatar = avatar, let data = avatar.jpeg(jpegQuality: .medium){
            let avatarFile = LCFile(payload: .data(data: data))
            avatarFile.save(record: kAvatarCol, table: user)
            
            meHeaderView.avatarImageView.image = avatar
        }
        
        //昵称
        try? user.set(kNickNameCol, value: nickName)
        meHeaderView.nickNameLabel.text = nickName
        
        //性别
        try? user.set(kGenderCol, value: gender)
        meHeaderView.genderLabel.text = gender ? "♂︎" : "♀︎"
        meHeaderView.genderLabel.textColor = gender ? blueColor : mainColor
        
        //生日--没有UI展示，所以直接存到云端即可
        try? user.set(kBirthCol, value: birth)
        
        //个人简介
        try? user.set(kIntroCol, value: intro)
        meHeaderView.introLabel.text = intro.isEmpty ? kIntroPH : intro
        
        user.save{ _ in }
        
        
    }
    
    
}
