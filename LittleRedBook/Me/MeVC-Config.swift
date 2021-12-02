//
//  MeVC-Config.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/8.
//

import Foundation
import LeanCloud

extension MeVC{
    func config(){
        navigationItem.backButtonTitle = ""
        
        if let user = LCApplication.default.currentUser, user == self.user{
            isMySelf = true
        }
    }
}
