//
//  HomeViewController.swift
//  Multiple_Section_TableView
//
//  Created by Mylo Ho on 6/28/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var sectionTableView: UITableView!
    
    let sections = ["Students", "Teachers", "Ghosts", "Gods", "Angels", "Demons"]
    
    let names = [["Student 1", "Student 2", "Student 3"], ["Teacher 1", "Teacher 2"], ["Ghost 1", "Ghost 2", "Ghost 3"], ["God 1", "God 2", "God 3", "God 4"], ["Angel 1", "Angel 2", "Angel 3", "Angel 4", "Angel 5"], ["Demon 1"] ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HOME"
        self.sectionTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.sectionTableView.delegate = self
        self.sectionTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = self.names[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell: CustomHeaderViewCell = NSBundle.mainBundle().loadNibNamed("CustomHeaderViewCell", owner: nil, options: nil)[0] as! CustomHeaderViewCell
        headerCell.backgroundColor = UIColor.grayColor()
        headerCell.label?.text = self.sections[section]
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerCell: CustomFooterViewCell = NSBundle.mainBundle().loadNibNamed("CustomFooterViewCell", owner: nil, options: nil)[0] as! CustomFooterViewCell
        footerCell.backgroundColor = UIColor.brownColor()
        return footerCell
    }
    
    
}