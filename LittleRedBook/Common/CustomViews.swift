//
//  CustomViews.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/27.
//

import Foundation
import UIKit

//可以实时展示在Storyboard中的自定义button样式
@IBDesignable
class BigButton: UIButton{
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        sharedInit()
    }
    
    
    func sharedInit(){
        backgroundColor = .secondarySystemBackground
        tintColor = .placeholderText
        setTitleColor(.placeholderText, for: .normal)
        
        contentHorizontalAlignment = .leading
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
    }
    
    
}
