//
//  CurrencyTableViewController.swift
//  test1
//
//  Created by lulouch on 10/29/16.
//  Copyright © 2016 lulouch. All rights reserved.
//

import UIKit

protocol currencyChange {
    func updateCurrencyButton()
}

class CurrencyTableViewController: UITableViewController {

    var masterVC : UIViewController? = nil
    var delegate : currencyChange? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = masterVC as! currencyChange?
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // The number of currencies
         return CurrencyDB.currencyList.count
     }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        // Configure the cell...
        let currentCurrency = CurrencyDB.currencySignList[indexPath.row]
        cell.textLabel?.text = currentCurrency
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get the cell
        let cell = tableView.cellForRow(at: indexPath)
        PriceDB.currentCurrency = (cell?.textLabel?.text)!
    }

}
