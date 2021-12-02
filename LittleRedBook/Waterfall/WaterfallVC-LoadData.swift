//
//  WaterfallVC-LoadData.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/15.
//

import Foundation
import CoreData
import LeanCloud

extension WaterfallVC{
    func getDraftNotes(){
        let request = DraftNote.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "updatedAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        request.propertiesToFetch = ["title", "coverPhoto", "updatedAt", "isVideo"]
        
        showLoadHUD()
        backgroundContext.perform {
            if let draftNotes = try? backgroundContext.fetch(request){
                self.draftNotes = draftNotes
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            self.hideLoadHUD()
        }
        
    }
    
    
    
    @objc func getNotes(){
        
        let query = LCQuery(className: kNoteTable)
        query.whereKey(kChannelCol, .equalTo(channel))
        query.whereKey(kAuthorCol, .included)
        query.whereKey(kUpdatedAtCol, .descending)
        query.limit = kNotesOffset
        
        query.find { result in
            switch result {
            case .success(objects: let notes):
                
                self.notes = notes
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                break
            case .failure(error: let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.header.endRefreshing()
            }
        }
        
    }
    
    @objc func getMyNotes(){
        let query = LCQuery(className: kNoteTable)
        query.whereKey(kAuthorCol, .equalTo(user!))
        query.whereKey(kAuthorCol, .included)
        query.whereKey(kUpdatedAtCol, .descending)
        query.limit = kNotesOffset
        
        query.find { result in
            switch result {
            case .success(objects: let notes):
                
                self.notes = notes
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                break
            case .failure(error: let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.header.endRefreshing()
            }
        }
    }
    
    @objc func getMyFavNotes(){
        getFavOrLike(className: kUserFavTable)
    }
    
    @objc func getMyLikeNotes(){
        getFavOrLike(className: kUserLikeTable)
    }
    
    func getFavOrLike(className: String){
        let query = LCQuery(className: className)
        query.whereKey(kUserCol, .equalTo(user!))
        query.whereKey(kNoteCol, .selected)
        query.whereKey(kNoteCol, .included)
        query.whereKey("\(kNoteCol).\(kAuthorCol)", .included)
        query.whereKey(kUpdatedAtCol, .descending)
        query.limit = kNotesOffset
        
        query.find { res in
            if case let .success(objects: userFavOrLike) = res{
                self.notes = userFavOrLike.compactMap{ $0.get(kNoteCol) as? LCObject }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            DispatchQueue.main.async {
                self.header.endRefreshing()
            }
        }
    }
    
}
