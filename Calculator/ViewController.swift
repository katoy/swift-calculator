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
    @IBOutlet var lblResult: UILabel!
    @IBOutlet var lblOpe: UILabel!

    var result:         Int! = nil
    var currentNumStr:  String = ""
    var currentOpe:     String! = nil
    var calcError:      String! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        calcInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setLabelResult(v: Int) {
        if (calcError != nil) {
            lblResult.text = "\(calcError)"
            println("result = \(calcError)")
            calcError = nil
            calcClear()
        } else {
            lblResult.text = "\(v)"
            println("result = \(v)")
        }
    }

    func setLabelOpe() {
        if currentOpe == nil {
            lblOpe.text = ""
        } else {
            lblOpe.text = "\(currentOpe)"
        }
        println("ope = \(currentOpe)")
    }

    func calcInit() {
        calcClear()
        setLabelResult(0)
    }
    
    func calcClear() {
        result = nil
        currentNumStr = ""
        currentOpe = nil
        setLabelOpe()
    }

    func calc(num1: Int, ope: String, num2: Int) -> Int {
        var ans = 0
        calcError = nil
        switch ope {
        case "＝":
            ans = num1
        case "＋":
            ans = num1 + num2
        case "ー":
            ans = num1 - num2
        case "ｘ":
            ans = num1 * num2
        case "÷":
            if num2 == 0 {
                calcError = "0 割り発生"
            } else {
                ans = num1 / num2
            }
        default:
            calcError = "エラー"
        }
        return ans
    }
    
    @IBAction func btnNumber(sender: UIButton) {
        // println(sender.titleLabel?.text!.toInt())
        let v = sender.titleLabel?.text!
        if v == "00" {
            if currentNumStr != "" {
                currentNumStr = currentNumStr + v!
            }
        } else {
            currentNumStr = currentNumStr + v!
        }
        var x: Int = 0
        if currentNumStr != "" {
            x = currentNumStr.toInt()!
        }
        setLabelResult(x)
    }

    @IBAction func btnOperate(sender: UIButton) {
        // println(sender.titleLabel?.text!)
        var v = sender.titleLabel?.text
        var error = ""

        if v == "-/+" {
            var neg = 0
            if currentNumStr != "" {
                neg = calc(0, ope: "ー", num2: currentNumStr.toInt()!)
            } else if result != nil {
                neg = calc(0, ope: "ー", num2: result)
            }
            currentNumStr = "\(neg)"
            setLabelResult(neg)
        } else if result != nil && currentNumStr != "" && currentOpe != nil {
            result = calc(result, ope: currentOpe, num2: currentNumStr.toInt()!)
            setLabelResult(result)
            currentNumStr = ""
        } else {
            if currentNumStr != "" {
                result = currentNumStr.toInt()!
            }
            currentNumStr = ""
        }

        if v == "＝"  {
            currentOpe = nil
        } else if v != "-/+" {
            currentOpe = v
        }
    
        setLabelOpe()
    }

    @IBAction func btnClear(sender: UIButton) {
        //println(sender.titleLabel?.text!)
        calcInit()
    }
}
