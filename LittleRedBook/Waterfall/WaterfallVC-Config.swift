//
//  WaterfallVC-Config.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/15.
//

import Foundation
import CHTCollectionViewWaterfallLayout

extension WaterfallVC{
    func config(){
        let layout = collectionView.collectionViewLayout as! CHTCollectionViewWaterfallLayout
        layout.columnCount = 2
        layout.minimumColumnSpacing = kWaterfallPadding
        layout.minimumInteritemSpacing = kWaterfallPadding
        
        if let _ = user{
            //个人页面--调整上方inset
            layout.sectionInset = UIEdgeInsets(top: 10, left: kWaterfallPadding, bottom: kWaterfallPadding, right: kWaterfallPadding)
        }else{
            //其他使用场景
            layout.sectionInset = UIEdgeInsets(top: 0, left: kWaterfallPadding, bottom: kWaterfallPadding, right: kWaterfallPadding)
        }
        

        if isDraft{
            //layout.sectionInset = UIEdgeInsets(top: 44, left: kWaterfallPadding, bottom: kWaterfallPadding, right: kWaterfallPadding)
            navigationItem.title = "本地草稿"
        }
        
        collectionView.register(UINib(nibName: "MyDraftNoteWaterfallCell", bundle: nil), forCellWithReuseIdentifier: kMyDraftNoteWaterfallCellID)
        
        collectionView.mj_header = header
    }
    
}
