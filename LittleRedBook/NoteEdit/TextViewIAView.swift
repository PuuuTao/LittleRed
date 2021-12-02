//
//  TextViewIAView.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/10.
//

import UIKit

class TextViewIAView: UIView {

    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var textCountStackView: UIStackView!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var maxTextCountLabel: UILabel!
    
    var currentCount = 0{
        didSet{
            if currentCount <= kMaxNoteTextCount{
                doneBtn.isHidden = false
                textCountStackView.isHidden = true
            }else{
                doneBtn.isHidden = true
                textCountStackView.isHidden = false
                textCountLabel.text = "\(currentCount)"
            }
        }
    }
    

}
