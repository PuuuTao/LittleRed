//
//  PhotoFooter.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/8.
//

import UIKit

class PhotoFooter: UICollectionReusableView {
        
    @IBOutlet weak var addPhotoBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addPhotoBtn.layer.borderWidth = 1
        addPhotoBtn.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
    
}
