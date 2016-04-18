//
//  ViewController.swift
//  CurrencyRates
//
//  Created by Grey.Luo on 16/4/18.
//  Copyright © 2016年 Grey.Luo. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toButton: UIButton!

    struct ExchangeResult {
        var rate: Float
        var update: String
    }

    var currencyTypes = [CurrencyType]()
    var result: ExchangeResult?

    struct ExchangeObject {
        var fromType: CurrencyType
        var toType: CurrencyType
    }
    var currentSelectedObject: ExchangeObject?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fromButtonPressedHandle(sender: UIButton) {
        self.performSegueWithIdentifier("selectTypeSegueIdentifier", sender: nil)
    }

    @IBAction func toButtonPressedHandle(sender: UIButton) {
        self.performSegueWithIdentifier("selectTypeSegueIdentifier", sender: nil)
    }

    @IBAction func exchange(sender: UIButton) {

    }
    // MARK: Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }

    //MARK: UITextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //MARK: Update UI
    func  updateUI() {
        print(currencyTypes)
//        timeLabel.text = "更新时间: " + result!.update
    }
   }

