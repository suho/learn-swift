//
//  HomeViewController.swift
//  Exercise6_Multiple_Section
//
//  Created by Mylo Ho on 6/29/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var employeesTableView: UITableView!
    
    var sections = [String]()
    
    var employees = [[AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HOME"
        self.getDataFromPlist()
        self.employeesTableView.delegate = self
        self.employeesTableView.dataSource = self
        self.employeesTableView.registerNib(UINib(nibName: "CEOTableViewCell", bundle: nil), forCellReuseIdentifier: "cellCEO")
        self.employeesTableView.registerNib(UINib(nibName: "ManagerTableViewCell", bundle: nil), forCellReuseIdentifier: "cellManager")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataFromPlist() {
        let path = NSBundle.mainBundle().pathForResource("employees", ofType: "plist")
        let dataDictionary = NSMutableDictionary(contentsOfFile: path!)
        sections = dataDictionary?.allKeys as! [String]
        
        let dataCEOs = dataDictionary?.objectForKey("ceos") as! NSArray
        var cEOs = [CEO]()
        for ceo in dataCEOs {
            let name = ceo.objectForKey("name") as! String
            let gender = ceo.objectForKey("gender") as! Bool
            let age = ceo.objectForKey("age") as! Int
            let avatar = ceo.objectForKey("avatar") as! String
            let avatarPath = ceo.objectForKey("avatarPath") as! String
            let dataCEO = CEO(avatar: avatar, name: name, age: age, gender: gender, avatarPath: avatarPath)
            cEOs.append(dataCEO)
        }
        employees.append(cEOs)
        
        let dataManagers = dataDictionary?.objectForKey("managers") as! NSArray
        var managers = [Manager]()
        for manager in dataManagers {
            let name = manager.objectForKey("name") as! String
            let gender = manager.objectForKey("gender") as! Bool
            let age = manager.objectForKey("age") as! Int
            let avatar = manager.objectForKey("avatar") as! String
            let avatarPath = manager.objectForKey("avatarPath") as! String
            let salary = manager.objectForKey("salary") as! Int
            
            let dataManager = Manager(avatar: avatar, name: name, age: age, gender: gender, avatarPath: avatarPath, salary: salary)
            managers.append(dataManager)
        }
        employees.append(managers)
        
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employees[section].count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: CustomHeaderViewCell = NSBundle.mainBundle().loadNibNamed("CustomHeaderViewCell", owner: nil, options: nil)[0] as! CustomHeaderViewCell
        switch section {
        case 0:
            headerView.backgroundColor = UIColor.grayColor()
            headerView.titleLabel.text = sections[section]
            headerView.iconImageView.image = UIImage(named: "ceo-icon")
            return headerView
        default:
            headerView.backgroundColor = UIColor.brownColor()
            headerView.titleLabel.text = sections[section]
            headerView.iconImageView.image = UIImage(named: "employee icon")
            return headerView
        }
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section {
        case 0:
            let detailCEO = DetailCEOViewController(nibName: "DetailCEOViewController", bundle: nil)
            detailCEO.indexRow = indexPath.row
            detailCEO.ceo = employees[indexPath.section][indexPath.row] as! CEO
            self.navigationController?.pushViewController(detailCEO, animated: true)
        default:
            let detailManager = DetailMangerViewController(nibName: "DetailMangerViewController", bundle: nil)
            detailManager.indexRow = indexPath.row
            detailManager.manager = employees[indexPath.section][indexPath.row] as! Manager
            self.navigationController?.pushViewController(detailManager, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("cellCEO", forIndexPath: indexPath) as! CEOTableViewCell
            let ceo: CEO = employees[indexPath.section][indexPath.row] as! CEO
            
            if ceo.avatar == "" {
                cell.avatarImage.image = UIImage(contentsOfFile: ceo.avatarPath)
            } else {
                cell.avatarImage.image = UIImage(named: ceo.avatar)
            }
            
            cell.name.text = ceo.name
            cell.age.text = "\(ceo.age)"
            cell.gender.text = (ceo.gender) ? "Male" : "Female"
            
            if cell.gender.text == "Male" {
                cell.gender.textColor = UIColor.brownColor()
            } else {
                cell.gender.textColor = UIColor.grayColor()
            }
            
            cell.accessoryType = UITableViewCellAccessoryType.DetailButton
            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("cellManager", forIndexPath: indexPath) as! ManagerTableViewCell
            
            let manager: Manager = employees[indexPath.section][indexPath.row] as! Manager
            
            if manager.avatar == "" {
                cell.avatar.image = UIImage(contentsOfFile: manager.avatarPath)
            } else {
                cell.avatar.image = UIImage(named: manager.avatar)
            }
            
            cell.name.text = manager.name
            cell.age.text = "\(manager.age)"
            cell.gender.text = (manager.gender) ? "Male" : "Female"
            
            if cell.gender.text == "Male" {
                cell.gender.textColor = UIColor.brownColor()
            } else {
                cell.gender.textColor = UIColor.grayColor()
            }
            
            cell.salary.text = "\(manager.salary)"
            
            cell.accessoryType = UITableViewCellAccessoryType.DetailButton
            return cell
        }
    }
    
}


