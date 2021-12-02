//
//  MeVC-UI.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/5.
//

import Foundation
import SegementSlide
import UIKit

extension MeVC{
    func setUI(){
        scrollView.backgroundColor = .systemBackground
        contentView.backgroundColor = .systemBackground
        switcherView.backgroundColor = .systemBackground
        
        let statusBarOverlayView = UIView(frame: CGRect(x: 0, y: 0, width: screenRect.width, height: statusBarHeight))
        statusBarOverlayView.backgroundColor = .systemBackground
        view.addSubview(statusBarOverlayView)
        
        defaultSelectedIndex = 0
        reloadData()
        
    }
    
}
