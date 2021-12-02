//
//  NoteEditVC-Config.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/10.
//

import Foundation

extension NoteEditVC{
    
    func config(){
        photoCollectionview.delegate = self
        photoCollectionview.dataSource = self
        photoCollectionview.dragDelegate = self
        photoCollectionview.dropDelegate = self
        
        photoCollectionview.dragInteractionEnabled = true
        
        titleTextField.delegate = self
        textView.delegate = self
        
        titleCountLabel.text = "\(kMaxNoteTitleCount)"
        
        hideKeyboardWhenTappedAround()
        
        locationManager.requestWhenInUseAuthorization()
        
        let lineFragmentPadding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -lineFragmentPadding, bottom: 0, right: -lineFragmentPadding)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let typingAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.secondaryLabel
        ]
        textView.typingAttributes = typingAttributes
        textView.tintColorDidChange()
        
        textView.inputAccessoryView = Bundle.loadNib(XIBName: "TextViewIAView", type: TextViewIAView.self)
        textViewIAView.doneBtn.addTarget(self, action: #selector(resignTextView), for: .touchUpInside)
        textViewIAView.maxTextCountLabel.text = "/\(kMaxNoteTextCount)"
        
    }
    
    @objc func resignTextView(){
        textView.resignFirstResponder()
    }
    
    
}
