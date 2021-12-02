//
//  SettingTableVC-Delegate.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/11.
//

import Foundation
import Kingfisher
import LeanCloud

extension SettingTableVC{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 1, row == 1{
            //清除缓存
            ImageCache.default.clearCache {
                self.showHUD(title: "清除缓存成功")
                self.cacheSizeLabel.text = "无缓存"
            }
        }else if section == 3{
            //跳转到appStore中进行评论
            let appID = "app打包到开发者后台之后才会获取到"
            let path = "https://itunes.apple.com/app/id\(appID)?action=write-review"
            guard let url = URL(string: path), UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url)
            
        }else if section == 4{
            //退出登录
            dismiss(animated: true)
            
            LCUser.logOut()
            let loginVC = storyboard!.instantiateViewController(withIdentifier: kLoginVCID)
            loginAndMeParentVC.removeChildren()
            loginAndMeParentVC.add(childVC: loginVC)
            
        }
        
        
        
    }
    
}
