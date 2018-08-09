//
//  SearchContainerViewController.swift
//  Itunes search
//
//  Created by Alejandro Moya on 09/08/2018.
//  Copyright © 2018 Alejandro Moya. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class SearchContainerViewController: BaseContainerViewController {
    
    let viewModel = SearchViewModel()
    var searchContainer = UIView.autoLayout()
    var searchControl: UISearchBar!
    var searchTable: SearchTableViewController!
    var filterControl: UISegmentedControl!
    
    override func configureAppearance() {
        super.configureAppearance()
        self.title = "Itunes Search"
        self.configureSearchBar()
        self.configureFilterControl()
        self.configureTable()
    }
    
    func configureSearchBar() {
        self.searchControl = UISearchBar(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 44)))
        self.searchContainer.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.searchContainer.addSubview(self.searchControl)
        self.containerStackView.addArrangedSubview(self.searchContainer)
        self.searchControl.reactive.continuousTextValues.skipNil().throttle(0.5, on: QueueScheduler.main).take(duringLifetimeOf: self).observeValues { [weak self](searchText) in
            guard let this = self else { return }
            this.viewModel.searchText = searchText
            this.search()
        }
    }
    
    func configureFilterControl() {
        self.filterControl = UISegmentedControl(items: SearchType.allDescriptions)
        self.filterControl.translatesAutoresizingMaskIntoConstraints = false
        self.filterControl.selectedSegmentIndex = 0
        let container = UIView.autoLayout()
        container.addSubview(self.filterControl)
        container.centerXAnchor.constraint(equalTo: self.filterControl.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.filterControl.centerYAnchor).isActive = true
        container.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.containerStackView.addArrangedSubview(container)
        self.filterControl.reactive.selectedSegmentIndexes.take(duringLifetimeOf: self).observeValues { [weak self](index) in
            guard let this = self else { return }
            switch index {
            case 1:
                this.viewModel.filter = .movie
            case 2:
                this.viewModel.filter = .tvShow
            default:
                this.viewModel.filter = .music
            }
            this.search()
        }
    }
    
    func configureTable() {
        self.searchTable = SearchTableViewController()
        self.searchTable.viewModel = self.viewModel
        self.addChildViewController(self.searchTable)
        self.containerStackView.addArrangedSubview(self.searchTable.tableView)
    }
    
    func search(complete: (() -> Void)? = nil) {
        if self.viewModel.searchText.count > 2 {
            self.viewModel.retrieveData {
                self.searchTable.tableView.reloadData()
                complete?()
            }
        } else {
            complete?()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateSearchBarFrame()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateSearchBarFrame()
    }
    
    func updateSearchBarFrame() {
        //As UISearcBar has some issues with the autolayout system we keep it's frame synced with the autolayout container, this allows customization
        self.searchControl.frame = CGRect(origin: .zero, size: CGSize(width: self.searchContainer.frame.width, height: 44))
    }
}
