//
//  ViewController.swift
//  Calculator
//
//  Created by katoy on 2014/12/29.
//  Copyright (c) 2014年 Youichi Kato. All rights reserved.
//
// See https://www.youtube.com/watch?v=j35eYoxieUw
//     https://www.youtube.com/watch?v=DGt1yBxBw9k
//     http://ja.stackoverflow.com/questions/2854/
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lblResult: UILabel!
    @IBOutlet var lblOpe: UILabel!

    var result:         Int! = nil
    var currentNumStr:  String = ""
    var currentOpe:     String! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        calcInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setLabelResult(info: (val: Int, error: String?)) {
        var text: String = "\(info.val)"
        if (info.error != nil) {
            calcClear()
            text = info.error!
        }
        lblResult.text = text
    }

    func setLabelOpe() {
        var text = ""
        if currentOpe != nil {
            text = "\(currentOpe)"
        }
        lblOpe.text = text
    }

    func calcInit() {
        calcClear()
        setLabelResult((0, nil))
    }

    func calcClear() {
        result = nil
        currentNumStr = ""
        currentOpe = nil
        setLabelOpe()
    }

    func calc(num1: Int, ope: String, num2: Int) -> (Int, String?) {
        
        let calcFuncs:[String: (Int, Int)->(Int, String?)] = [
            "＝": calc_eq,
            "＋": calc_add,
            "ー": calc_sub,
            "ｘ": calc_mul,
            "÷": calc_div,
            "％": calc_mod,
            "-/+": calc_minus
        ]
        return calcFuncs[ope]!(num1, num2)
    }

    func calc_eq(num1: Int, num2: Int) ->(Int, String?) {
        return(num2, nil)
    }
    func calc_add(num1: Int, num2: Int) ->(Int, String?) {
        return(num1 + num2, nil)
    }
    func calc_sub(num1: Int, num2: Int) ->(Int, String?) {
        return(num1 - num2, nil)
    }
    func calc_mul(num1: Int, num2: Int) ->(Int, String?) {
        return(num1 * num2, nil)
    }
    func calc_div(num1: Int, num2: Int) ->(Int, String?) {
        if num2 == 0 {
            return(0, "Divie by 0")
        } else {
            return(num1 / num2, nil)
        }
    }
    func calc_mod(num1: Int, num2: Int) ->(Int, String?) {
        if num2 == 0 {
            return(0, "Divie by 0")
        } else {
            return(num1 % num2, nil)
        }
    }
    func calc_minus(num1: Int, num2: Int) ->(Int, String?) {
        return(num2 * (-1), nil)
    }

    @IBAction func btnNumber(sender: UIButton) {
        // println(sender.titleLabel?.text!.toInt())
        let v = sender.titleLabel?.text!
        if v == "00" {
            if currentNumStr != "" {
                currentNumStr = currentNumStr + v!
            } else {
                currentNumStr = "0"
            }
        } else {
            currentNumStr = currentNumStr + v!
        }
        var x: Int = 0
        if currentNumStr != "" {
            x = currentNumStr.toInt()!
        }
        setLabelResult((x, nil))
    }

    @IBAction func btnOperate(sender: UIButton) {
        // println(sender.titleLabel?.text!)
        var v = sender.titleLabel?.text
        var rets: (val: Int, error: String?) = (0, nil)

        if v == "-/+" {
            if currentNumStr != "" {
                rets = calc(0, ope: "ー", num2: currentNumStr.toInt()!)
            } else if result != nil {
                rets = calc(0, ope: "ー", num2: result)
            }
            setLabelResult(rets)
            currentNumStr = "\(rets.val)"
        } else if result != nil && currentNumStr != "" && currentOpe != nil {
            rets = calc(result, ope: currentOpe, num2: currentNumStr.toInt()!)
            setLabelResult(rets)
            if rets.error == nil {
                result = rets.val
            }
            currentNumStr = ""
        } else {
            if currentNumStr != "" {
                result = currentNumStr.toInt()!
            }
            currentNumStr = ""
        }

        if v == "＝" {
            currentOpe = nil
        } else if v != "-/+" {
            currentOpe = v
        }
        setLabelOpe()
    }

    @IBAction func btnClear(sender: UIButton) {
        // println(sender.titleLabel?.text!)
        calcInit()
    }
}