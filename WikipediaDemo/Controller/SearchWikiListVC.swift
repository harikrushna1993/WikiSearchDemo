//
//  ViewController.swift
//  WikipediaDemo
//
//  Created by Hari Krushna Sahu on 08/09/18.
//  Copyright © 2018 Hari. All rights reserved.
//

import UIKit

class SearchWikiListVC: UIViewController {
    @IBOutlet weak var tableviewSearchList: UITableView!
    
    var sampleData = [SearchWikiDataModel]() {
        didSet {
            tableviewSearchList.reloadData()
        }
    }
    let searchWikiViewModel = SearchWikiViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        setUpSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }

   private func customizeUI() {
        tableviewSearchList.estimatedRowHeight = 10
        tableviewSearchList.rowHeight = UITableViewAutomaticDimension
    }

   private func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Wikipedia"
        definesPresentationContext = true
        self.navigationItem.searchController = searchController;
        searchController.isActive = true
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: UISearchController Protocol Methods
extension SearchWikiListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        searchWikiViewModel.searchWikipediaAPI(searchString: searchString!) { (dataModel) in
            self.sampleData = dataModel
        }
    }
}

extension SearchWikiListVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let wikiDataCell = tableView.dequeueReusableCell(withIdentifier: "WikiPediaListTableViewCell", for: indexPath) as? WikiPediaListTableViewCell else {
            return UITableViewCell()
        }
        wikiDataCell.loadCellData(data: sampleData[indexPath.row])
        return wikiDataCell
    }
}

extension SearchWikiListVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let detailVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WikiDetailVC") as? WikiDetailVC else {
            return
        }
        detailVC.urlString = "http://en.wikipedia.org/?curid=\(sampleData[indexPath.row].pageId)"
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

