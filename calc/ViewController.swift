//
//  ViewController.swift
//  calc
//
//  Created by iOSDev on 2021/06/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private var pastNum: Int = 0
    private var currentNum: Int = 0
    private var currentOp: String = ""
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func tapNumBtn(_ sender: UIButton) {
        currentNum *= 10
        currentNum += Int((sender.titleLabel?.text)!)!
        
        updateLabel(true)
    }

    @IBAction func tapACBtn(_ sender: Any) {
        currentOp = ""
        pastNum = 0
        currentNum = 0
        updateLabel(true)
        
    }
    @IBAction func tapOpBtn(_ sender: UIButton) {
        if (currentOp == "") {
            pastNum = currentNum
            currentNum = 0
        }
        currentOp = (sender.titleLabel?.text)!
        
        updateLabel(false)
    }
    
    @IBAction func tapEqBtn(_ sender: Any) {
        switch currentOp {
            case "+":
                currentNum = pastNum + currentNum
            case "-":
                currentNum = pastNum - currentNum
            case "*":
                currentNum = pastNum * currentNum
            case "/":
                currentNum = pastNum / currentNum
            default:
                return
        }
        currentOp = ""
        updateLabel(true)
    }
    func updateLabel(_ isViewCurrentZero: Bool) {
        label.text = ""
        if (currentOp != "") {
            label.text! += String(pastNum)
            label.text! += currentOp
        }
        if(isViewCurrentZero || currentNum != 0) {
            label.text! += String(currentNum)
        }
    }

}

