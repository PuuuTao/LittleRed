//
//  AppDelegate-Push.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/15.
//

import Foundation
import LeanCloud

extension AppDelegate{
    
    //获取device token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //保存device token到后端
        LCApplication.default.currentInstallation.set(
            deviceToken: deviceToken,
            apnsTeamId: "R79332U368")  //Team ID
        LCApplication.default.currentInstallation.save { _ in }
    }
    
}
