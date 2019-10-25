//
//  SearchControllerType.swift
//  makeFile
//
//  Created by Tatsuya Yamamoto on 2019/10/25.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

public protocol SearchControllerType: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
  var searchController: UISearchController { get set }
  var hidesSearchBarWhenScrolling: Bool { get }
  func setupSearchController()
}

extension SearchControllerType where Self: UITableViewController {
  public func setupSearchController() {
    definesPresentationContext = true
    searchController.searchResultsUpdater = self
    searchController.delegate = self
    searchController.hidesNavigationBarDuringPresentation = true
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
    searchController.searchBar.searchBarStyle = UISearchBar.Style.prominent
    searchController.searchBar.sizeToFit()
    if #available(iOS 11.0, *) {
      navigationItem.hidesSearchBarWhenScrolling = hidesSearchBarWhenScrolling
      navigationItem.searchController = searchController
    } else {
      tableView.tableHeaderView = searchController.searchBar
    }
  }
}
