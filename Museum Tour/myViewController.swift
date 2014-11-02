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
    @IBAction func MexicanArt(sender: AnyObject) {
        instance.gal = 1
    }
    @IBAction func RomanArt(sender: AnyObject) {
        instance.gal = 2
    }
    
    @IBAction func IndoPacificArt(sender: AnyObject) {
        instance.gal = 3
    }

    @IBAction func PermanentArt(sender: AnyObject) {
        instance.gal = 4
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
