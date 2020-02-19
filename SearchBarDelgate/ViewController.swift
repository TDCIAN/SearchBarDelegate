//
//  ViewController.swift
//  SearchBarDelgate
//
//  Created by hexlant_01 on 2020/02/19.
//  Copyright © 2020 hexlant_01. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cellId = "cellId"
    var tempArray = ["iPhone", "MacBook", "iPad", "iMac", "AirPods", "Apple Watch"]
    var filteredArray = [String]()
    var isSearching = false
    
    lazy var mainTable: UITableView = {
       let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return table
    }()
    
    lazy var mainSearchBar: UISearchBar = {
       let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        mainTable.delegate = self
        mainTable.dataSource = self
        mainSearchBar.delegate = self
        mainSearchBar.returnKeyType = UIReturnKeyType.done
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
    }
    
    func setupView() {
        view.addSubview(mainSearchBar)
        view.addSubview(mainTable)
        
        mainSearchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        mainSearchBar.heightAnchor.constraint(equalToConstant: 200).isActive = true
        mainSearchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainSearchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        mainTable.topAnchor.constraint(equalTo: mainSearchBar.bottomAnchor, constant: 10).isActive = true
        mainTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainTable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredArray.count
        } else {
            return tempArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var device: String?
        if isSearching {
            device = filteredArray[indexPath.row]
        } else {
            device = tempArray[indexPath.row]
        }
        let cell = mainTable.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
        cell.textLabel?.text = device
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if mainSearchBar.text == nil || mainSearchBar.text == "" {
            isSearching = false
            mainTable.reloadData()
        } else {
            isSearching = true
            filteredArray = tempArray.filter({$0.range(of: mainSearchBar.text!, options: .caseInsensitive) != nil })
            mainTable.reloadData()
        }
    }
    
}
