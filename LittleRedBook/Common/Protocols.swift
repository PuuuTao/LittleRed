//
//  Protocols.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/11.
//

import Foundation

protocol ChannelVCDelegate {
    func updateChannel(channel: String, subChannel: String)
}

protocol POIVCDelegate {
    func updatePOIName(name: String)
}

protocol IntroVCDelegate{
    func updateIntro(intro: String)
}

protocol EditProfileTableVCDelegate{
    func updateUser(avatar: UIImage?, nickName: String, gender: Bool, birth: Date?, intro: String)
}
