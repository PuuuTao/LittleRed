//
//  POIVC-KeywordsSearch.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/13.
//

import Foundation

extension POIVC: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            pois = aroundSearchPOIs
            setAroundSearchFooter()
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isBlank else { return }
        
        keywords = searchText
        pois.removeAll()
        currentKeywordsPage = 1
        footer.resetNoMoreData()
        footer.setRefreshingTarget(self, refreshingAction: #selector(keywordsSearchPullToRefresh))
        showLoadHUD()
        keywordsSearch(keywords: keywords)
        view.endEditing(true)
    }
    
    
}


extension POIVC: AMapSearchDelegate{
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        hideLoadHUD()
        
        if response.count > kPOIsOffset{
            pagesCount = (response.count / kPOIsOffset) + 1
        }else{
            footer.endRefreshingWithNoMoreData()
        }
        
        if response.count == 0 {
               return
           }
        for poi in response.pois{
            let province = poi.province == poi.city ? "" : poi.province
            let address = poi.district == poi.address ? "" : poi.address
            let poi = [poi.name ?? kNoPOIPH, "\(province.unwrappedText)\(poi.city.unwrappedText)\(poi.district.unwrappedText)\(address.unwrappedText)"]
            pois.append(poi)
            
            if request is AMapPOIAroundSearchRequest{
                aroundSearchPOIs.append(poi)
            }
        }
        tableView.reloadData()
      
    }
}

extension POIVC{
    func keywordsSearch(keywords: String, page: Int = 1){
        keywordsSearchRequest.keywords = keywords
        keywordsSearchRequest.page = page
        mapSearch?.aMapPOIKeywordsSearch(keywordsSearchRequest)
    }
}


extension POIVC{
    @objc func keywordsSearchPullToRefresh(){
        currentKeywordsPage += 1
        keywordsSearch(keywords: keywords, page: currentKeywordsPage)
        if currentKeywordsPage < pagesCount{
            footer.endRefreshing()
        }else{
            footer.endRefreshingWithNoMoreData()
        }
    }
    
}
