//
//  SubViewController.swift
//  calc
//
//  Created by iOSDev on 2021/06/22.
//

import UIKit

class SubViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var table: UITableView!
    
    var recent: [(([NSDecimalNumber], [String]), NSDecimalNumber)] = []
    var vc: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vc = self.presentingViewController as? ViewController
        recent = vc!.recent
        table.delegate = self
        table.dataSource = self
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(sender:)))
        longPressRecognizer.delegate = self
        table.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        let point = sender.location(in: table)
        let indexPath = table.indexPathForRow(at: point)

        if indexPath != nil && sender.state == UIGestureRecognizer.State.began{
            if vc?.currentNum == nil {
                let ((numArray, opArray), _) = recent[indexPath!.row]
                vc?.numArray.append(contentsOf: numArray.dropLast())
                vc?.opArray.append(contentsOf: opArray)
                vc?.currentNum = numArray.last
                vc?.syncCurrentNumAfterPoint()
                vc?.updateLabel()
                dismiss(animated: true, completion: nil)
            }
        }
    }}

extension SubViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recent.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "History"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let ((numArray, opArray), answer) = recent[indexPath.row]
        
        cell.textLabel?.text = answer.stringValue
        var formula = ""
        var count = 0
        while count < opArray.count {
            formula += numArray[count].stringValue
            formula += opArray[count]
            count += 1
        }
        formula += numArray.last!.stringValue
        cell.detailTextLabel?.text = formula
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vc?.currentNum = recent[indexPath.row].1
        vc?.syncCurrentNumAfterPoint()
        vc?.updateLabel()
        dismiss(animated: true, completion: nil)
    }
}
