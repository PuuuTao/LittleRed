//
//  POIVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/12.
//

import UIKit

class POIVC: UIViewController {
    
    var delegate: POIVCDelegate?

    lazy var locationManager = AMapLocationManager()
    lazy var mapSearch = AMapSearchAPI()
    lazy var aroundSearchRequest: AMapPOIAroundSearchRequest = {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(latitude), longitude: CGFloat(longitude))
        request.offset = kPOIsOffset
        return request
    }()
    lazy var keywordsSearchRequest: AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.offset = kPOIsOffset
        request.requireExtension = true
        return request
    }()
    lazy var footer = MJRefreshAutoNormalFooter()
    
    
    var pois = kPOIsInitArr
    var aroundSearchPOIs = kPOIsInitArr
    var latitude = 0.0
    var longitude = 0.0
    var keywords = ""
    var currentAroundPage = 1
    var currentKeywordsPage = 1
    var pagesCount = 1
    var poiName = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        requestLocation()
        mapSearch?.delegate = self
        
    }
    
}


extension POIVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .checkmark
        delegate?.updatePOIName(name: pois[indexPath.row][0])
        dismiss(animated: true)
    }
}

extension POIVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPOICellID, for: indexPath) as! POICell
        
        let poi = pois[indexPath.row]
        cell.poi = poi
        
        if poi[0] == poiName{ cell.accessoryType = .checkmark }
        
        return cell
    }
    
    
}
