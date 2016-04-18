//
//  CurencyTypeSelectViewController.swift
//  CurrencyRates
//
//  Created by Grey.Luo on 16/4/18.
//  Copyright © 2016年 Grey.Luo. All rights reserved.
//

import UIKit

struct CurrencyType {
    var code: String
    var name: String
}

class CurencyTypeSelectViewController: UITableViewController {
    var currencyTypes = [CurrencyType]()
    var selectedType: CurrencyType?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getCurrencyTypes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyTypes.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "reuseIdentifier"
        var cell: UITableViewCell?  = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell  == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
        let type = currencyTypes[indexPath.row]
        cell!.textLabel!.text = type.name
        cell!.detailTextLabel!.text = type.code
        return cell!
    }
    //MARK: UITableDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    //MARK: Net Request
    func getCurrencyTypes() {
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
    func cacheTypes(types: NSArray) {
        for type in types {
            let code = type.objectForKey("curno") as! String
            let name = type.objectForKey("curnm") as! String
            print("code:" + code + "name:" + name)
            let type = CurrencyType(code: code, name: name)
            currencyTypes.append(type)
        }
    }
}
