//
//  WaterfallVC-DataSource.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/15.
//

import Foundation

extension WaterfallVC{
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isMyDraft{
            return notes.count + 1
        }else if isDraft{
            return draftNotes.count
        }else{
            return notes.count
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isMyDraft, indexPath.item == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMyDraftNoteWaterfallCellID, for: indexPath)
            return cell
        }else if isDraft{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDraftNoteWaterFallCellID, for: indexPath) as! DraftNoteWaterFallCell
            cell.deleteBtn.tag = indexPath.item
            cell.deleteBtn.addTarget(self, action: #selector(deleteDraftNote), for: .touchUpInside)
            cell.draftNote = draftNotes[indexPath.item]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KWaterfallCellID, for: indexPath) as! WaterfallCell
            cell.isMyselfLike = isMyselfLike
            let offset = isMyDraft ? 1 : 0
            cell.note = notes[indexPath.item - offset]
            return cell
        }
        
    }

}


extension WaterfallVC{
    @objc func deleteDraftNote(sender: UIButton){
        let alert = UIAlertController(title: "提示", message: "确认删除该草稿吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        let doneAction = UIAlertAction(title: "确认", style: .destructive) { _ in
            
            DispatchQueue.main.async {
                let draftNote = self.draftNotes[sender.tag]
                backgroundContext.delete(draftNote)
                appDelegate.saveBackgroundContext()
                self.draftNotes.remove(at: sender.tag)
                UserDefaults.decrease(key: kDraftNoteCount)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.showHUD(title: "删除草稿成功")
                }
            }
            
        }
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        present(alert, animated: true)
    }
}
