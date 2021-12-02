//
//  WaterfallVC-Layout.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/9.
//

import Foundation
import CHTCollectionViewWaterfallLayout

extension WaterfallVC: CHTCollectionViewDelegateWaterfallLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (screenRect.width - 3*kWaterfallPadding) / 2
        var cellHeight: CGFloat = 0
        
        if isMyDraft, indexPath.item == 0{
            cellHeight = 100
        }else if isDraft{
            let draftNote = draftNotes[indexPath.item]
            let image = UIImage(data: draftNote.coverPhoto) ?? imagePH
            let imageWidth = image.size.width
            let imageHeight = image.size.height
            let imageRadio = imageHeight / imageWidth
            cellHeight = cellWidth * imageRadio + kDraftNoteWaterfallCellBottomViewHeight
            
        }else{
            let offset = isMyDraft ? 1 : 0
            let note = notes[indexPath.item - offset]
            let coverPhotoRatio = CGFloat(note.getExactDoubleVal(col: kCoverPhotoRatioCol))
            cellHeight = cellWidth * coverPhotoRatio + kWaterfallCellBottomViewHeight
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}

