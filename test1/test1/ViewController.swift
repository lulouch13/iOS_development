//
//  ViewController.swift
//  test1
//
//  Created by lulouch on 10/29/16.
//  Copyright © 2016 lulouch. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, currencyChange, unitChange {
    
    @IBOutlet weak var currencyButton: UIButton!
    var currentCurrency : String = "USD"
    
    @IBOutlet weak var unitButton: UIButton!
    var currentUnit : String = "lb"
    
    func updateCurrencyButton() {
        currencyButton.setTitle(PriceDB.currentCurrency, for: .normal)
        currencyButton.titleLabel?.textAlignment = .center
    }
    
    func updateUnitButton() {
        unitButton.setTitle(PriceDB.currentUnit, for: .normal)
        unitButton.titleLabel?.textAlignment = .center
    }
    
    @IBOutlet weak var priceTable: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(PriceDB.priceList == nil) {
            return 0
        }
        else {
            return PriceDB.priceList!.count
        }
    }
    
    var totalWidth : Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceTable.sectionHeaderHeight = 100
        totalWidth = Double(priceTable.frame.width)
        
        PriceDB.priceList = nil
        PriceDB.unitPriceList = nil
        PriceDB.currency_unitList = nil
        
        priceInput.text = ""
        amountInput.text = ""
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateCurrencyButton()
        updateUnitButton()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        // Cell format: currency + total price + amount + unit price
        let (currentCurrency, currentPrice, currentAmount, currentUnit) = (PriceDB.priceList?[indexPath.row])!
        let currentUnitPrice : Double = PriceDB.unitPriceList[indexPath.row]
        let currency_unit = PriceDB.currency_unitList[0]
        cell.textLabel?.text = currentCurrency + String(currentPrice) + ", n: " + String(currentAmount) + currentUnit + ".  Ave: " + String(currentUnitPrice) + currency_unit
        return cell
    }

    
    // Buttons: add, delete, clear and compare
    let add_button = UIButton()
    let delete_button = UIButton()
    let clear_button = UIButton()
    let compare_button = UIButton()
    
    // Add Buttons
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: totalWidth, height: 100))
        // position of label and button
        let h : Double = 50
        let hGap : Double = 5
        
        let buttonGap : Double = 8
        let buttonWidth : Double = Double(totalWidth - 5 * buttonGap) / 4.0 - 2
        
        add_button.frame = CGRect(x: buttonGap, y: hGap, width: buttonWidth, height: h)
        delete_button.frame = CGRect(x: buttonWidth + 2*buttonGap, y: hGap, width: buttonWidth, height: h)
        clear_button.frame = CGRect(x: 2*buttonWidth + 3*buttonGap, y: hGap, width: buttonWidth, height: h)
        compare_button.frame = CGRect(x: 3*buttonWidth + 4*buttonGap, y: hGap, width: buttonWidth, height: h)
        
        
        add_button.backgroundColor = UIColor.init(red: 204/255, green: 255/255, blue: 204/255, alpha: 1.0)
        delete_button.backgroundColor = UIColor.init(red: 255/255, green: 204/255, blue: 204/255, alpha: 1.0)
        clear_button.backgroundColor = UIColor.init(red: 255/255, green: 153/255, blue: 153/255, alpha: 1.0)
        compare_button.backgroundColor = UIColor.init(red: 204/255, green: 229/255, blue: 255/255, alpha: 1.0)
        
        // button color and text
        add_button.setTitle("+", for: UIControlState.normal)
        add_button.layer.cornerRadius = 5
        add_button.setTitleColor(UIColor.black, for: UIControlState.normal)
        delete_button.setTitle("-", for: UIControlState.normal)
        delete_button.setTitleColor(UIColor.black, for: UIControlState.normal)
        delete_button.layer.cornerRadius = 5
        clear_button.setTitle("AC", for: UIControlState.normal)
        clear_button.setTitleColor(UIColor.black, for: UIControlState.normal)
        clear_button.layer.cornerRadius = 5
        compare_button.setTitle("Sort", for: UIControlState.normal)
        compare_button.setTitleColor(UIColor.black, for: UIControlState.normal)
        compare_button.layer.cornerRadius = 5
        
        // button function
        add_button.addTarget(self, action: #selector(addNewPrice), for: .touchDown)
        delete_button.addTarget(self, action: #selector(deletePrice), for: .touchDown)
        clear_button.addTarget(self, action: #selector(clearPrice), for: .touchDown)
        compare_button.addTarget(self, action: #selector(comparePrice), for: .touchDown)
        
        // add all button
        view.addSubview(add_button)
        view.addSubview(delete_button)
        view.addSubview(clear_button)
        view.addSubview(compare_button)
        
        return view
    }
    
    @IBOutlet weak var priceInput: UITextField!
    @IBOutlet weak var amountInput: UITextField!
    
    // add a price into the table
    func addNewPrice() {
        // input price when there is a price
        
        if(Double(priceInput.text!) != nil && Double(amountInput.text!) != nil && Double(amountInput.text!) != 0) {
            let new_amount : Double = Double(amountInput.text!)!
            let new_price : Double = Double(priceInput.text!)!
            let inputCurrency : String = PriceDB.currentCurrency
            let inputUnit : String = PriceDB.currentUnit
            
            let newcell : (String, Double, Double, String) = (inputCurrency, new_price, new_amount, inputUnit)
            
            if PriceDB.priceList == nil {
                PriceDB.priceList = [newcell]
            }
            else {
                PriceDB.priceList.append(newcell)
            }
            
            let addcell = priceComparisonMethods()
            let (new_unitPrice, currency_unit) = addcell.changeToUnitPrice()
            
            if PriceDB.unitPriceList == nil {
                PriceDB.unitPriceList = [new_unitPrice]
                PriceDB.currency_unitList = [currency_unit]
            }
            else {
                PriceDB.unitPriceList.append(new_unitPrice)
                PriceDB.currency_unitList.append(currency_unit)
            }
        }
        
        priceTable.reloadData()
    }
    
    // delete the most recent price in the table
    func deletePrice() {
        if(PriceDB.priceList != nil && PriceDB.priceList.count != 0) {
            PriceDB.priceList.remove(at: ((PriceDB.priceList.count) - 1))
            PriceDB.unitPriceList.remove(at: (PriceDB.unitPriceList.count) - 1)
            PriceDB.currency_unitList.remove(at: (PriceDB.currency_unitList.count) - 1)
            priceTable.reloadData()
        }
        else {
            priceTable.reloadData()
        }
    }
    
    // clear all price information
    func clearPrice() {
        PriceDB.priceList = nil
        PriceDB.unitPriceList = nil
        PriceDB.currency_unitList = nil
        priceTable.reloadData()
    }
    
    // compare the prices
    func comparePrice() {
        if(PriceDB.unitPriceList != nil) {
            let cellIndex = priceComparisonMethods().priceComparison()
            let (currentCurrency, currentPrice, currentAmount, currentUnit) = (PriceDB.priceList?[cellIndex])!
            priceTable.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "currencySegue" {
            let dst = segue.destination as! CurrencyTableViewController
            dst.masterVC = self
        }
        else if segue.identifier == "unitSegue" {
            let dst = segue.destination as! UnitTableViewController
            dst.masterVC = self
        }

    }
    
}

