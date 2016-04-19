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
        var fromType: CurrencyType?
        var toType: CurrencyType?
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
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }

    func performUnwindSegue(segue: UIStoryboardSegue) {
        if segue.identifier == CurencyTypeSelectViewController.UnwindSegue {
            if (segue.sourceViewController as! CurencyTypeSelectViewController).selectFor
            currentSelectedObject?.fromType = (segue.sourceViewController as! CurencyTypeSelectViewController).selectedType
        }
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

    //MARK: Net Request
    func exchange() {
        let urlString = "http://api.k780.com:88/?app=finance.rate_curlist&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json"
        let encodedUrlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let session = NSURLSession.sharedSession()
        let request = NSURLRequest(URL: NSURL(string:encodedUrlString!)!)
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                if let rs = json.objectForKey("result") as? NSArray {
                    self.cacheTypes(rs)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }

}

