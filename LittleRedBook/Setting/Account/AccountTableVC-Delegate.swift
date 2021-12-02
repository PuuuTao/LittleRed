//
//  AccountTableVC-Delegate.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/11.
//

import Foundation

extension AccountTableVC{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0{
            if row == 0{
                //绑定，换绑手机号
                print("绑定，换绑手机号")
            }else if row == 1{
                //设置密码
                if let _ = phoneNum{
                    performSegue(withIdentifier: "showPasswordTableVC", sender: nil)
                }else{
                    showHUD(title: "需要先绑定手机号哦")
                }
                
            }
        }
    }
    
}
