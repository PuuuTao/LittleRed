//
//  NoteDetailVC-Fav.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/29.
//

import Foundation
import LeanCloud

extension NoteDetailVC{
    
    //收藏相关操作--和点赞类似
    func fav(){
        
        if let _ = LCApplication.default.currentUser{
            
            //UI
            isFav ? (favCount += 1) : (favCount -= 1)
            
            //数据
            //防止用户暴力点击
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(favBtnTappedWhenLogin), object: nil)
            perform(#selector(favBtnTappedWhenLogin), with: nil, afterDelay: 1)
            
        }else{
            showHUD(title: "登录之后才可以收藏笔记哦")
        }
        
    }
    
    
    @objc func favBtnTappedWhenLogin(){
        if favCount != currentFavCount{
            
            let user = LCApplication.default.currentUser!
            let authorObjectID = user.objectId?.stringValue ?? ""
            
            let offset = isFav ? 1 : -1
            currentFavCount += offset
            
            if isFav{
                let userFav = LCObject(className: kUserFavTable)
                
                try? userFav.set(kUserCol, value: user)
                try? userFav.set(kNoteCol, value: note)
                userFav.save { _ in }
                
                try? note.increase(kFavCountCol)
                note.save { _ in }
                
                LCObject.userInfoIncrease(userObjectID: authorObjectID, col: kFavCountCol)
                
            }else{
                let query = LCQuery(className: kUserFavTable)
                
                query.whereKey(kUserCol, .equalTo(user))
                query.whereKey(kNoteCol, .equalTo(note))
                
                query.getFirst { res in
                    if case let .success(object: userFav) = res{
                        userFav.delete { _ in }
                    }
                }
                
                try? note.set(kFavCountCol, value: favCount)
                note.save { _ in }
                
                LCObject.userInfoDecrease(userObjectID: authorObjectID, col: kFavCountCol, to: favCount)

            }
        }
    }
    
    
    
    
    
    
}

