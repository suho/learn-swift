//
//  Contact.swift
//  Exercise7_AddressBook_Index
//
//  Created by Mylo Ho on 6/30/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation
import UIKit
import Contacts

class Contact: NSObject {
    var name: String = ""
    var phone: String = ""
    var image: UIImage?
    
    init(name: String, phone: String, image: UIImage) {
        self.name = name
        self.phone = phone
        self.image = image
    }
    
    init?(cnContact: CNContact) {
        
        if !cnContact.isKeyAvailable(CNContactGivenNameKey) && !cnContact.isKeyAvailable(CNContactFamilyNameKey) {return nil}
        
        self.name = (cnContact.familyName + " " + cnContact.givenName).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        self.image = (cnContact.isKeyAvailable(CNContactImageDataKey) && cnContact.imageDataAvailable) ? UIImage(data: cnContact.imageData!) : nil
        
        if cnContact.isKeyAvailable(CNContactPhoneNumbersKey) {
            if cnContact.phoneNumbers.count > 0 {
                let phone = cnContact.phoneNumbers.first?.value as? CNPhoneNumber
                self.phone = (phone?.stringValue)!
            }
        }
        
    }
}