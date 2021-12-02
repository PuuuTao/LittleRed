//
//  MeVC-BackOrSlide.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/8.
//

import Foundation

extension MeVC{
    @objc func backOrSlide(sender: UIButton){
        if isFromNote{
            dismiss(animated: true)
        }else{
            //抽屉drawer效果
        }
    }
}
