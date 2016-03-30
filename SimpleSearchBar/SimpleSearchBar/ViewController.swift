//
//  ViewController.swift
//  SimpleSearchBar
//
//  Created by Sean Calkins on 3/21/16.
//  Copyright © 2016 Sean Calkins. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    let citiesArray = ["Salt Lake City",
        "Compton", "Magna", "Fillmore", "Hannah", "Scipio", "Kearns", "West Valley City", "Logan"]
    
    var resultsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultsArray = self.citiesArray
    }
    
    
    //MARK: - Search Bar delegate methods
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        print("searchBar cancel")
        self.restoreSearchBar("")
    }
    
    //Sets the displayed array to the cities array when text is done editing
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        print("search bar end editing")
        searchBar.resignFirstResponder()
        self.resultsArray = self.citiesArray
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.resultsArray.removeAll()
        
        for city in citiesArray {
            // if the city starts with the letter "searchText" then put it in the results array
           
            if self.containsString(city, searchText: searchText) {
                self.resultsArray.append(city)
            }
        }
        print(self.resultsArray)
        
        self.tableView.reloadData()
        self.restoreSearchBar(searchText)
        
    }
    
    func restoreSearchBar(searchText: String) {
        if searchText == "" {
            self.searchBar.text = ""
            self.resultsArray = self.citiesArray
            self.tableView.reloadData()
            self.searchBar.resignFirstResponder()
        }
    }
    
    func containsString(str: String, searchText: String) -> Bool {
        
        let lowercaseString = str.lowercaseString
        let lowercaseSearchText = searchText.lowercaseString
        
        return lowercaseString.hasPrefix(lowercaseSearchText)
    }
    
    //MARK: Table View Delegate and Datasource Methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        cell.textLabel?.text = resultsArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count;
    }
}

