//
//  NYTimesHomeViewController.swift
//  NYTimes
//
//  Created by Karan Thakkar on 17/10/18.
//  Copyright © 2018 TLIKnowledge. All rights reserved.
//

import UIKit
import AFNetworking
import SKActivityIndicatorView
import DAAlertController

class NYTimesHomeViewController: UITableViewController, UISearchResultsUpdating {
    
    var mostPopularDataArray : NSMutableArray?
    var searchDataArray:NSMutableArray!
    var nyTimesDataModel:NYTimesModel!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        callMostPopularAPIData()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150.0
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    
    // Mark: - TableView data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if getMostPopularNewsArray()?.count != 0 {
            return 1
        }
        return 0
    }
    
    //Mark: - UITableView Number of Rows in Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let itemArray = getMostPopularNewsArray()
        {
            return itemArray.count
        }
        return 0
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mostPopularCell : NYTimesHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "mostPopularNewsCell", for: indexPath) as! NYTimesHomeTableViewCell
        
        if let itemArray = getMostPopularNewsArray()
        {
            mostPopularCell.displayNewsData(newsData: itemArray.object(at: indexPath.row) as! NSDictionary)
        }
        
        return mostPopularCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  let tableViewCell = sender as? NYTimesHomeTableViewCell
        {
            let indePath = tableView.indexPath(for: tableViewCell)
            let newsArray = getMostPopularNewsArray()
            if let categoryData = newsArray?.object(at: indePath?.row ?? 0) as? NSDictionary
            {
                if let webURL = categoryData.value(forKey: "url") as? String
                {
                    let vc = segue.destination as! NYTimesNewsDetailViewController
                    vc.webURL = webURL
                }
            }
        }
    }
    
    // call MostPopular API
    func callMostPopularAPIData()
    {
        SKActivityIndicator.show("Loading...", userInteractionStatus: true)
        
        let serviceCallObject = ServiceCallModel()
        serviceCallObject.callMostViewdAPI { [unowned self] (status, info)  in
            DispatchQueue.main.async {
                SKActivityIndicator.dismiss()
            }
            if status == ServerConnectionResponseStatus.ServerConnectionResponseStatusSuccess.hashValue
            {
                if let mostPopularNewsData = info as? NSDictionary
                {
                    if let mutableFeedData = mostPopularNewsData.value(forKey: "results") as? NSArray
                    {
                        self.mostPopularDataArray = mutableFeedData.mutableCopy() as? NSMutableArray;
                    }
                    
                    // Reload UITableView
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }else
            {
                DispatchQueue.main.async {
                    let okayAction = DAAlertAction.init(title: "Ok", style: .default) {
                    }
                    DAAlertController.showAlert(of: .alert, in: self, withTitle: "Alert", message: "Something went wrong.Please try again!", actions: [okayAction!])
                }
            }
        }
    }
    
    // Return Array based on Search or Without Search
    func getMostPopularNewsArray() -> NSMutableArray?
    {
        let mutableArray:NSMutableArray?
        
        if doFilter()
        {
            mutableArray = self.searchDataArray
        }
        else
        {
            mutableArray = self.mostPopularDataArray
        }
        return mutableArray
    }
    
    // Check Search Controller is Active or Not
    func doFilter() -> Bool
    {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    // Search Delegate
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.isEmpty == false
        {
            if nyTimesDataModel ==  nil
            {
                nyTimesDataModel = NYTimesModel()
            }
            self.searchDataArray = nyTimesDataModel.searchMostPopularNewsModel(searchString: searchController.searchBar.text ?? "", mostPopularNewsArray: self.mostPopularDataArray ?? NSMutableArray())
        }
        else
        {
            searchDataArray = nil
        }
        self.tableView.reloadData()
    }
}

