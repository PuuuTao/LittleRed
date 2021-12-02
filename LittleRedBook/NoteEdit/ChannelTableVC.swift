//
//  ChannelTableVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/11.
//

import UIKit
import XLPagerTabStrip

class ChannelTableVC: UITableViewController {
    
    var channel = ""
    var subChannels = [""]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subChannels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSubChannelCellID, for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = "# \(subChannels[indexPath.row])"
        content.textProperties.font = .systemFont(ofSize: 15)
        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let channelVC = parent as! ChannelVC
        channelVC.PVDelegate?.updateChannel(channel: channel, subChannel: subChannels[indexPath.row])
        dismiss(animated: true)
    }
    

    
}


extension ChannelTableVC: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: channel)
    }
}
