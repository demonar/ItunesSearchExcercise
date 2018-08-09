//
//  SearchTableViewController.swift
//  Itunes search
//
//  Created by Alejandro Moya on 09/08/2018.
//  Copyright © 2018 Alejandro Moya. All rights reserved.
//

import UIKit
import AVKit

class SearchTableViewController: BaseTableViewController {
    let identifier = SearchResultTableViewCell.identifier
    var viewModel: SearchViewModel?
    
    override func configureData() {
        self.tableView.register(UINib(nibName: self.identifier, bundle: nil), forCellReuseIdentifier: self.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.results.count ?? 0
    }
    
    override func refresh(_ refreshControl: UIRefreshControl?) {
        if let container = self.parent as? SearchContainerViewController {
            container.search {
                refreshControl?.endRefreshing()
            }
        } else {
            refreshControl?.endRefreshing()
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! SearchResultTableViewCell
        if let element = self.viewModel?.results[indexPath.row] as? SearchElement {
            cell.searchElement = element
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let element = self.viewModel?.results[indexPath.row] as? SearchElement,
            let urlString = element.previewUrl,
            let url = URL(string: urlString) {
            let playerVC = AVPlayerViewController()
            let player = AVPlayer(url: url)
            playerVC.player = player
            self.parent?.navigationController?.pushViewController(playerVC, animated: true)
        }
    }
}
