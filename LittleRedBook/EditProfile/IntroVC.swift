//
//  IntroVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/10.
//

import UIKit

class IntroVC: UIViewController {
    
    var intro = ""

    var delegate: IntroVCDelegate?
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
        textView.text = intro
        countLabel.text = "\(kMaxIntroCount)"
        
    }
    
    @IBAction func done(_ sender: Any) {
        delegate?.updateIntro(intro: textView.exactText)
        dismiss(animated: true)
    }
    
    

}


extension IntroVC: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        guard textView.markedTextRange == nil else { return }
        countLabel.text = "\(kMaxIntroCount - textView.text.count)"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let isExceed = range.location >= kMaxIntroCount || (textView.text.count + text.count) > kMaxIntroCount
        if isExceed{ showHUD(title: "个人简介最多只能输入\(kMaxIntroCount)字哦") }
        return !isExceed
    }
}
