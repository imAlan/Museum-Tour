//
//  myViewController.swift
//  Museum Tour
//
//  Created by Alan Chen on 11/1/14.
//  Copyright (c) 2014 Urban Games. All rights reserved.
//

import UIKit

var gallery:Int!

class myViewController: UIViewController {
    @IBAction func AsianArt(sender: AnyObject) {
        instance.gal = 0
    }
    @IBAction func AfricanArt(sender: AnyObject) {
        print ("AA")
        instance.gal = 1
        print (instance.gal)
    }
    @IBAction func EuropeanArt(sender: AnyObject) {
        instance.gal = 2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
