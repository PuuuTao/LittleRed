//
//  MyDraftNoteWaterfallCell.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/9.
//

import UIKit

class MyDraftNoteWaterfallCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countLabel.text = "\(UserDefaults.standard.integer(forKey: kDraftNoteCount))"
    }

}
