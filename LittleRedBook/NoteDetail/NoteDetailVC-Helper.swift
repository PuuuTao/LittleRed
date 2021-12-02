//
//  NoteDetailVC-Helper.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/1.
//

import Foundation
import LeanCloud

extension NoteDetailVC{
    
    func showDeleteAlert(name: String, confirmHandler: ((UIAlertAction) -> ())?) {
        let alert = UIAlertController(title: "提示", message: "确认删除\(name)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        let doneAction = UIAlertAction(title: "确认", style: .default, handler: confirmHandler)
        
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        present(alert, animated: true)
    }
    
    func comment(){
        if let _ = LCApplication.default.currentUser{
            isReply = false
            textView.placeholder = "点赞是喜欢，评论是真爱"
            textView.becomeFirstResponder()
            textViewBarView.isHidden = false
        }else{
            showHUD(title: "登录之后再评论哦")
        }
    }
}
