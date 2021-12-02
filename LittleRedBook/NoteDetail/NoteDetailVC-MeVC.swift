//
//  NoteDetailVC-MeVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/8.
//

import Foundation
import LeanCloud

extension NoteDetailVC{
    func noteToMeVC(user: LCUser?){
        guard let user = user else { return }
        
        if isFromMeVC, let fromMeVCUser = fromMeVCUser, fromMeVCUser == user{
            dismiss(animated: true)
        }else{
            let meVC = storyboard!.instantiateViewController(identifier: kMeVCID) { coder in
                MeVC(coder: coder, user: user)
            }
            meVC.isFromNote = true
            meVC.modalPresentationStyle = .fullScreen
            present(meVC, animated: true)
        }
        
    }
    
    @objc func goToMeVC(tap: UIPassableTapGestureRecognizer){
        let user = tap.passObject
        noteToMeVC(user: user)
    }
}

