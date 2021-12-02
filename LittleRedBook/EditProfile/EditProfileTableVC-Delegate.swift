//
//  EditProfileTableVC-Delegate.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/10.
//

import Foundation
import PhotosUI
import ActionSheetPicker_3_0
import DateToolsSwift

extension EditProfileTableVC{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        switch indexPath.row{
        case 0:
            //头像
            var config = PHPickerConfiguration()
            config.filter = .images
            config.selectionLimit = 1
            let vc = PHPickerViewController(configuration: config)
            vc.delegate = self
            present(vc, animated: true)
        case 1:
            //昵称
            print("修改昵称和修改个人简介一样")
        case 2:
            //性别
            let acp = ActionSheetStringPicker(title: nil, rows: ["男","女"], initialSelection: gender ? 0 : 1, doneBlock: { (_, index, _) in
                self.gender = index == 0
            }, cancel: { _ in }, origin: cell)
            acp?.show()
        case 3:
            //生日
            var selectedDate = Date().subtract(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 20))
            
            if let birth = birth{
                selectedDate = birth
            }
            let datePicker = ActionSheetDatePicker(
                title: nil,
                datePickerMode: .date,
                selectedDate: selectedDate,
                doneBlock: { (_, date, _) in
                    self.birth = date as? Date
                },
                cancel: { _ in },
                origin: cell)
            
            datePicker?.minimumDate = Date().subtract(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 60))
            datePicker?.maximumDate = Date()
            
            datePicker?.show()
            
        case 4:
            //个人简介
            let vc = storyboard!.instantiateViewController(withIdentifier: kIntroVCID) as! IntroVC
            vc.intro = intro
            vc.delegate = self
            present(vc, animated: true)
            
        default:
            break
        }
        
        
    }
    
}

extension EditProfileTableVC: IntroVCDelegate{
    func updateIntro(intro: String) {
        self.intro = intro
    }
    
    
}
