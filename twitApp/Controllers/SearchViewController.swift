//
//  SearchViewController.swift
//  twitApp
//
//  Created by Dayana Marden on 16.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var tableView : UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor(displayP3Red: 212/255, green: 212/255, blue: 212/255, alpha: 1)
        view.rowHeight = 90
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var data = [Posts]()
    var filterData = [Posts]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SearchBar"
        view.addSubview(tableView)
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.text = "#"
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "#" {
            return filterData.count
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!SearchTableViewCell
        
        if searchController.isActive && searchController.searchBar.text != "#" {
            cell.hashtagLabel.text = self.filterData[indexPath.row].hachtag
            cell.emailLabel.text = self.filterData[indexPath.row].email
            cell.dateLabel.text = self.filterData[indexPath.row].date
            cell.textsLabel.text = self.filterData[indexPath.row].text
        } else {
            cell.hashtagLabel.text = self.data[indexPath.row].hachtag
            cell.emailLabel.text = self.data[indexPath.row].email
            cell.dateLabel.text = self.data[indexPath.row].date
            cell.textsLabel.text = self.data[indexPath.row].text
        }
        return cell
    }
    
    func filterContentForSearching(searchText: String) {
        filterData = data.filter { data in
            return (data.hachtag?.lowercased().contains(searchText.lowercased()))!
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newViewController = HashTagViewController()
        
        if searchController.isActive && searchController.searchBar.text != "#" {
            newViewController.text = filterData[indexPath.row].hachtag!
        } else {
            newViewController.text = data[indexPath.row].hachtag!
        }
        
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
}

extension SearchViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearching(searchText: searchController.searchBar.text!)
    }
}


