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
    
    private var numArray: [Double] = []
    private var opArray: [String] = []
    
    private var currentNum: Double? = nil
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func tapNumBtn(_ sender: UIButton) {
        if currentNum == nil {
            currentNum = 0
        }
        currentNum! *= 10
        currentNum! += Double((sender.titleLabel?.text)!)!
        
        updateLabel()
    }

    @IBAction func tapACBtn(_ sender: Any?) {
        currentNum = nil
        numArray = []
        opArray = []
        label.text = "0"
    }
    
    @IBAction func tapOpBtn(_ sender: UIButton) {
        if currentNum == nil && opArray.count >= 1 {
            opArray[opArray.count - 1] = (sender.titleLabel?.text)!
        } else {
            numArray.append(currentNum ?? 0)
            opArray.append((sender.titleLabel?.text)!)
            currentNum = nil
        }
        updateLabel()
    }
    
    @IBAction func tapEqBtn(_ sender: Any) {
        numArray.append(currentNum ?? 0)
        
        var count = 0
        while count < opArray.count {
            switch opArray[count] {
            case "*":
                numArray[count] = numArray[count] * numArray[count + 1]
                numArray.remove(at: count + 1)
                opArray.remove(at: count)
                
            case "/":
                if numArray[count + 1] == 0 {
                    tapACBtn(nil)
                    label.text = "ERROR: Divide by Zero"
                    return
                }
                numArray[count] = numArray[count] / numArray[count + 1]
                numArray.remove(at: count + 1)
                opArray.remove(at: count)
                
            default:
                count += 1
            }
           
        }
        
        count = 0
        while count < opArray.count {
            switch opArray[count] {
            case "+":
                numArray[count] = numArray[count] + numArray[count + 1]
                numArray.remove(at: count + 1)
                opArray.remove(at: count)
                
            case "-":
                numArray[count] = numArray[count] - numArray[count + 1]
                numArray.remove(at: count + 1)
                opArray.remove(at: count)
                
            default:
                count += 1
            }
        }
        
        currentNum = numArray[0]
        numArray = []
        opArray = []
        updateLabel()
    }

    func updateLabel() {
        var formula = ""
        var count = 0
        while count < numArray.count {
            formula += removePZero(String(numArray[count]))
            formula += opArray[count]
            count += 1
        }
        if currentNum != nil {
            formula += removePZero(String(currentNum ?? 0))
        }
        label.text = formula
    }
    
    func removePZero(_ str: String) -> String {
        var str1 = str
        if str1.suffix(2) == ".0" {
            str1.removeLast(2)
        }
        return str1
    }

}

