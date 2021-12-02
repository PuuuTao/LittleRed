//
//  EditProfileTableVC-UI.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/10.
//

import Foundation
import Kingfisher

extension EditProfileTableVC{
    func setUI(){
        avatarImageView.kf.setImage(with: user.getImageURL(col: kAvatarCol, type: .avatar))
        nickName = user.getExactStringVal(col: kNickNameCol)
        gender = user.getExactBoolVal(col: kGenderCol)
        birth = user.get(kBirthCol)?.dateValue
        intro = user.getExactStringVal(col: kIntroCol)
    }
}
