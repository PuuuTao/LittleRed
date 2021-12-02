//
//  POICell.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/12.
//

import UIKit

class POICell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    
    var poi = ["",""]{
        didSet{
            nameLabel.text = poi[0]
            addressLabel.text = poi[1]
        }
    }

}
