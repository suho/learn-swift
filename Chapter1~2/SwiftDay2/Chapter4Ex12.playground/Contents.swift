//: Playground - noun: a place where people can play

import UIKit

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        print("...")
        return
    }
     print("Hello \(name)")
    
    guard let location = person["location"] else {
        print("I hope weather...")
        return
    }
    
    print("I hope ... \(location)")
}

//greet(["name": "John"])
//greet(["name": "Jane", "location": "vietnam"])
//greet(["location": "danang"])