//
//  UnitTableViewController.swift
//  test1
//
//  Created by lulouch on 11/5/16.
//  Copyright © 2016 lulouch. All rights reserved.
//

import UIKit

protocol unitChange {
    func updateUnitButton()
}

class UnitTableViewController: UITableViewController {
    
    var masterVC : UIViewController? = nil
    var delegate : unitChange? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = masterVC as! unitChange?

        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UnitDB.unitList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        // Configure the cell...
        let currentUnit = UnitDB.unitSignList[indexPath.row]
        cell.textLabel?.text = currentUnit
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get the cell
        let cell = tableView.cellForRow(at: indexPath)
        PriceDB.currentUnit = (cell?.textLabel?.text)!
    }
}
