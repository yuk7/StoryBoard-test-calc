//
//  SubViewController.swift
//  calc
//
//  Created by iOSDev on 2021/06/22.
//

import UIKit

class SubViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    
    var recent: [(String, Double)] = []
    var vc: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vc = self.presentingViewController as? ViewController
        recent = vc!.recent
        table.delegate = self
        table.dataSource = self
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
        let item = recent[indexPath.row]
        cell.textLabel?.text = String(item.1)
        cell.detailTextLabel?.text = item.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vc?.tapACBtn(nil)
        vc?.currentNum = recent[indexPath.row].1
        vc?.updateLabel()
        dismiss(animated: true, completion: nil)
    }
    
}
