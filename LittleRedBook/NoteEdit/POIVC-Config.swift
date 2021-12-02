//
//  POIVC-Config.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/12.
//

import Foundation

extension POIVC{
    func config(){
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.locationTimeout = 5
        locationManager.reGeocodeTimeout = 5
        
        tableView.mj_footer = footer
        
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton{
            cancelButton.isEnabled = true
        }
    }
}
