//
//  WaterfallVC-Delegate.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/15.
//

import Foundation

extension WaterfallVC{
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isMyDraft, indexPath.item == 0{
            let navi = storyboard!.instantiateViewController(withIdentifier: kDraftNotesNaviID) as! UINavigationController
            navi.modalPresentationStyle = .fullScreen
            ((navi.topViewController) as! WaterfallVC).isDraft = true
            present(navi, animated: true)
        }else if isDraft{
            let draftNote = draftNotes[indexPath.item]
            if let photosData = draftNote.photos,
               let photoDataArr = try? JSONDecoder().decode([Data].self, from: photosData){
                let photos = photoDataArr.map { data -> UIImage in
                    UIImage(data: data) ?? imagePH
                }
                let videoURL = FileManager.default.save(data: draftNote.video, dirName: "video", fileName: "\(UUID().uuidString).mp4")
                let noteEditVC = storyboard!.instantiateViewController(withIdentifier: kNoteEditVCID) as! NoteEditVC
                noteEditVC.draftNote = draftNote
                noteEditVC.photos = photos
                noteEditVC.videoURL = videoURL
                noteEditVC.updateDraftNoteFinished = {
                    self.getDraftNotes()
                }
                noteEditVC.postDraftNoteFinished = {
                    self.getDraftNotes()
                }
                
                navigationController?.pushViewController(noteEditVC, animated: true)
                
            }else{
                showHUD(title: "加载草稿失败")
            }
            
        }else{
            let offset = isMyDraft ? 1 : 0
            let detailVC = storyboard!.instantiateViewController(identifier: kNoteDetailVCID) { coder in
                NoteDetailVC(coder: coder, note: self.notes[indexPath.item - offset])
            }
            if let cell = collectionView.cellForItem(at: indexPath) as? WaterfallCell{
                detailVC.isLikeFromWaterfallCell = cell.isLike
            }
            detailVC.deleteNoteFinished = {
                self.notes.remove(at: indexPath.item - offset)
                collectionView.performBatchUpdates {
                    collectionView.deleteItems(at: [indexPath])
                }
            }
            detailVC.isFromMeVC = isFromMeVC
            detailVC.fromMeVCUser = fromMeVCUser
            detailVC.modalPresentationStyle = .fullScreen
            present(detailVC, animated: true)
        }
    }
    
}
