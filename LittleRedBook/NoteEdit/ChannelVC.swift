//
//  ChannelVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/11.
//

import UIKit
import XLPagerTabStrip

class ChannelVC: ButtonBarPagerTabStripViewController {
    
    var PVDelegate: ChannelVCDelegate?

    override func viewDidLoad() {
        
        settings.style.selectedBarBackgroundColor = mainColor
        settings.style.selectedBarHeight = 2
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarItemTitleColor = .label
        settings.style.buttonBarItemFont = .systemFont(ofSize: 15)
        settings.style.buttonBarItemLeftRightMargin = 0
        
        super.viewDidLoad()

        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label

        }
    }
    

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var vcs: [UIViewController] = []
        for index in kChannels.indices{
            let vc = storyboard!.instantiateViewController(withIdentifier: kChannelTableVCID) as! ChannelTableVC
            vc.channel = kChannels[index]
            vc.subChannels = kAllSubChannels[index]
            vcs.append(vc)
        }
        return vcs
    }
    
   

}
