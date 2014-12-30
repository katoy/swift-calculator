//
//  ViewController.swift
//  Calculator
//
//  Created by katoy on 2014/12/29.
//  Copyright (c) 2014年 Youichi Kato. All rights reserved.
//
// See https://www.youtube.com/watch?v=j35eYoxieUw
//     https://www.youtube.com/watch?v=DGt1yBxBw9k
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnNumber(sender: UIButton) {
        println(sender.titleLabel?.text!.toInt())
    }

    @IBAction func btnOperate(sender: UIButton) {
        println(sender.titleLabel?.text!)
    }
    
    @IBAction func btnClear(sender: UIButton) {
        println(sender.titleLabel?.text!)
    }
}

