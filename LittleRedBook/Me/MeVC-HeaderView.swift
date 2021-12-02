//
//  MeVC-HeaderView.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/8.
//

import Foundation
import LeanCloud

extension MeVC{
    func setHeaderView() -> UIView{
        
        meHeaderView.translatesAutoresizingMaskIntoConstraints = false
        meHeaderView.heightAnchor.constraint(equalToConstant: meHeaderView.rootStackView.frame.height + 26).isActive = true
        meHeaderView.user = user
        if isFromNote{
            meHeaderView.backOrSlideBtn.setImage(largeIcon(iconName: "chevron.left", iconColor: .label), for: .normal)
        }
        meHeaderView.backOrSlideBtn.addTarget(self, action: #selector(backOrSlide), for: .touchUpInside)
        
        if isMySelf{
            
            meHeaderView.introLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editIntro)))
            
        }else{
            
            if user.getExactStringVal(col: kIntroCol).isEmpty{
                meHeaderView.introLabel.isHidden = true
            }
            
            if let _ = LCApplication.default.currentUser{
                meHeaderView.editOrFollowBtn.setTitle("关注", for: .normal)
                meHeaderView.editOrFollowBtn.backgroundColor = mainColor
            }else{
                meHeaderView.editOrFollowBtn.setTitle("关注", for: .normal)
                meHeaderView.editOrFollowBtn.backgroundColor = mainColor
            }
            
            meHeaderView.settingOrChatBtn.setImage(fontIcon(iconName: "ellipsis.bubble", iconColor: .label, fontSize: 13), for: .normal)
            
        }
        
        meHeaderView.editOrFollowBtn.addTarget(self, action: #selector(editOrFollow), for: .touchUpInside)
        meHeaderView.settingOrChatBtn.addTarget(self, action: #selector(settingOrChat), for: .touchUpInside)
        
        
        
        return meHeaderView
    }
}
