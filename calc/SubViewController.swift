//
//  SubViewController.swift
//  calc
//
//  Created by iOSDev on 2021/06/22.
//

import UIKit

class SubViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    
    var recent: [(([Double], [String]), Double)] = []
    var vc: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vc = self.presentingViewController as? ViewController
        recent = vc!.recent
        table.delegate = self
        table.dataSource = self        
    }
    
    func fixNumStr(_ str: String) -> String {
        var str1 = str
        if str1.suffix(2) == ".0" {
            str1.removeLast(2)
        }
        return str1
    }
}

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
        
        cell.textLabel?.text = String(answer)
        var formula = ""
        var count = 0
        while count < opArray.count {
            formula += fixNumStr(String(numArray[count]))
            formula += opArray[count]
            count += 1
        }
        formula += fixNumStr(String(numArray.last!))
        cell.detailTextLabel?.text = formula
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vc?.tapACBtn(nil)
        vc?.currentNum = recent[indexPath.row].1
        vc?.updateLabel()
        dismiss(animated: true, completion: nil)
    }
    
}
