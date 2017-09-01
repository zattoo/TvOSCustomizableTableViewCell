//
//  ViewController.swift
//  TvOSCustomizableTableViewCell-Example
//
//  Created by David Cordero on 25.08.17.
//  Copyright © 2017 Zattoo. All rights reserved.
//

import UIKit
import TvOSCustomizableTableViewCell

class ViewController: UIViewController, UITableViewDataSource {
    
    private var tableView: UITableView!
    
    private let colors: [UIColor] = [.red, .green, .yellow, .blue, .orange, .gray, .purple, .brown, .cyan, .magenta]
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TvOSCustomizableTableViewCell
        
        cell.textLabel?.text = "Item \(indexPath.row)"
        cell.focusedTitleColor = colors[Int(arc4random_uniform(10))]
        cell.focusedBackgroundColor = colors[Int(arc4random_uniform(10))]
        cell.normalTitleColor = colors[Int(arc4random_uniform(10))]
        cell.normalBackgroundColor = .clear
        cell.normalBackgroundEndColor = .clear
        cell.selectedBackgroundColor = colors[Int(arc4random_uniform(10))]
        cell.focusedScaleFactor = 1.05
        
        return cell
    }
    
    // MARK: Private
    
    private func setUpTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.register(TvOSCustomizableTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 400).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -400).isActive = true
    }
}
