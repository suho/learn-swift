//
//  HomeViewController.swift
//  Exercise7_AddressBook_Index
//
//  Created by Mylo Ho on 6/30/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import Contacts

class HomeViewController: UIViewController {

    @IBOutlet weak var contactsTableView: UITableView!
    
    var contactStore = CNContactStore()
    
    var allSections = [String]()
    
    var sections = [String]()
    
    struct Contacts {
        var sectionName : String!
        var sectionContact: [Contact]!
    }
    
    var arrayContacts = [Contacts]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
        self.contactsTableView.registerNib(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "cellContact")
        
        var contacts = [Contact]()
        
        do {
            let contactsFetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactImageDataKey, CNContactImageDataAvailableKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey])
            try contactStore.enumerateContactsWithFetchRequest(contactsFetchRequest, usingBlock: { (cnContact, error) in
                if let contact = Contact(cnContact: cnContact) { contacts.append(contact) }
            })
        } catch {
            print("Error Contact!!")
        }
        
        self.sections = getSections(contacts)
        
        for i in 65...90 {
            self.allSections.append(String(UnicodeScalar(i)))
        }
        
        var contactsDictionary = Dictionary<String, [Contact]>()
        
        contactsDictionary = self.getDictionaryFromArray(contacts)
        
        for (key, value) in contactsDictionary {
            self.arrayContacts.append(Contacts(sectionName: key, sectionContact: value))
        }
        
        self.arrayContacts  = self.arrayContacts.sort { $0.0.sectionName < $0.1.sectionName  }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cutName(name: String) -> String {
        let nameArray = name.componentsSeparatedByString(" ")
        return (String(nameArray[0][nameArray[0].startIndex]) + " " + String(nameArray[1][nameArray[1].startIndex]))
    }
    
    func getSections(contacts: [Contact]) -> [String]{
        var namesOfContacts = [String]()
        for contact in contacts {
            namesOfContacts.append(contact.name)
        }
        var firstCharacters = Set<String>()
        for name in namesOfContacts {
            firstCharacters.insert(String(name[name.startIndex]))
        }
        
        return Array(firstCharacters).sort {$0 < $1}
    }
    
    func getDictionaryFromArray(contacts: [Contact]) -> Dictionary<String, [Contact]> {
        var result: Dictionary<String, [Contact]> = [:]
        
        let sections = getSections(contacts)
        
        for section in sections {
            var dataContact = [Contact]()
            for contact in contacts {
                if section == String(contact.name[contact.name.startIndex]) {
                    dataContact.append(contact)
                }
            }
            result[section] = dataContact
        }
        return result
    }

}

//UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.arrayContacts.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayContacts[section].sectionContact.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.arrayContacts[section].sectionName
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150.6
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellContact", forIndexPath: indexPath) as! ContactTableViewCell
        let contact = self.arrayContacts[indexPath.section].sectionContact[indexPath.row]
        
        if contact.image == nil {
            cell.textName = cutName(contact.name)
            contact.image = UIImage(named: "gray")
        }
        
        cell.configureWithContact(contact)
        return cell
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.allSections
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        
        let temp = self.sections as NSArray
        
        for section in self.sections {
            if title == section {
                return temp.indexOfObject(title)
            }
        }
        return -1
    }
    
}
