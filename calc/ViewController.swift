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
    
    public var recent: [(([NSDecimalNumber], [String]), NSDecimalNumber)] = []
    
    public var numArray: [NSDecimalNumber] = []
    public var opArray: [String] = []
    
    public var currentNum: NSDecimalNumber? = nil
    public var currentNumLenAfterPoint = -1
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func tapNumBtn(_ sender: UIButton) {
        let tappedNum = NSDecimalNumber(value: Int((sender.titleLabel?.text)!)!)
        if currentNum == nil {
            currentNum = 0
        }
        if currentNumLenAfterPoint < 0 {
            currentNum = currentNum!.multiplying(by: 10)
            if currentNum!.doubleValue >= 0 {
                currentNum = currentNum!.adding(tappedNum)
            } else {
                currentNum = currentNum!.subtracting(tappedNum)
            }
        } else {
            var currentPosition = NSDecimalNumber(0.1)
            for _ in 0..<currentNumLenAfterPoint {
                currentPosition = currentPosition.multiplying(by: NSDecimalNumber(0.1))
            }
            currentNum = currentNum?.adding(tappedNum.multiplying(by: currentPosition))
            currentNumLenAfterPoint += 1
        }
        
        updateLabel()
    }

    @IBAction func tapACBtn(_ sender: Any?) {
        currentNum = nil
        syncCurrentNumAfterPoint()
        numArray = []
        opArray = []
        label.text = "0"
    }
    
    @IBAction func tapPointBtn(_ sender: Any) {
        if currentNumLenAfterPoint < 0 {
            currentNumLenAfterPoint = 0
            updateLabel()
        }
    }
    
    @IBAction func tapOpBtn(_ sender: UIButton) {
        if currentNum == nil && opArray.count >= 1 {
            opArray[opArray.count - 1] = (sender.titleLabel?.text)!
        } else {
            numArray.append(currentNum ?? 0)
            opArray.append((sender.titleLabel?.text)!)
            currentNum = nil
            syncCurrentNumAfterPoint()
            currentNumLenAfterPoint = -1
        }
        updateLabel()
    }
    
    @IBAction func tapEqBtn(_ sender: Any) {
        numArray.append(currentNum ?? 0)
        
        var numArray_ = numArray
        var opArray_ = opArray
        
        var count = 0
        while count < opArray_.count {
            switch opArray_[count] {
            case "*":
                numArray_[count] = numArray_[count].multiplying(by: numArray_[count + 1])
                numArray_.remove(at: count + 1)
                opArray_.remove(at: count)
                
            case "/":
                if numArray_[count + 1] == 0 {
                    tapACBtn(nil)
                    label.text = "ERROR: Divide by Zero"
                    return
                }
                numArray_[count] = numArray_[count].dividing(by: numArray_[count + 1])
                numArray_.remove(at: count + 1)
                opArray_.remove(at: count)
                
            default:
                count += 1
            }
           
        }
        
        count = 0
        while count < opArray_.count {
            switch opArray_[count] {
            case "+":
                numArray_[count] = numArray_[count].adding(numArray_[count + 1])
                numArray_.remove(at: count + 1)
                opArray_.remove(at: count)
                
            case "-":
                numArray_[count] = numArray_[count].subtracting(numArray_[count + 1])
                numArray_.remove(at: count + 1)
                opArray_.remove(at: count)
                
            default:
                count += 1
            }
        }
        
        currentNum = numArray_[0]
        syncCurrentNumAfterPoint()
        recent.append(((numArray, opArray), currentNum!))
        numArray = []
        opArray = []
        updateLabel()
    }

    func updateLabel() {
        var formula = ""
        var count = 0
        while count < numArray.count {
            formula += numArray[count].stringValue
            formula += opArray[count]
            count += 1
        }
        if currentNum != nil {
            var currentNumStr = (currentNum ?? NSDecimalNumber(0)).stringValue
            if currentNumLenAfterPoint >= 0 {
                var countAfterPoint = 0
                if !currentNumStr.contains(".") {
                    currentNumStr += "."
                } else {
                    countAfterPoint = currentNumStr.split(separator:".")[1].count
                }
                for _ in (countAfterPoint ..< currentNumLenAfterPoint) {
                        print(currentNumLenAfterPoint)
                        currentNumStr += "0"
                }
            }
            formula += currentNumStr
        }
        label.text = formula
    }
    
    func syncCurrentNumAfterPoint() {
        if currentNum == nil {
            currentNumLenAfterPoint = -1
        } else {
            let currentNumStr = (currentNum ?? NSDecimalNumber(0)).stringValue
            currentNumLenAfterPoint = -1
            if currentNumStr.contains(".") {
                currentNumLenAfterPoint = currentNumStr.split(separator:".")[1].count
            }
        }
    }
}
