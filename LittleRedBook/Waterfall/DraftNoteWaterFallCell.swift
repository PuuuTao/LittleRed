//
//  DraftNoteWaterFallCell.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/14.
//

import UIKit

class DraftNoteWaterFallCell: UICollectionViewCell {
    
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var isVideoImageView: UIImageView!
    
    var draftNote: DraftNote?{
        didSet{
                guard let draftNote = draftNote else { return }
                
                titleLabel.text = draftNote.title!.isEmpty ? "无标题" : draftNote.title!
                imageVIew.image = UIImage(data: draftNote.coverPhoto) ?? imagePH
                isVideoImageView.isHidden = !draftNote.isVideo
                dateLabel.text = draftNote.updatedAt?.formattedDate
                
            
            
        }
    }
    
    
    
    
    
}
