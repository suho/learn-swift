//
//  HomeViewController.swift
//  CharactersOfString
//
//  Created by Mylo Ho on 6/22/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var textFieldInput: UITextField!
    @IBOutlet weak var labelCountCharacters: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelCountCharacters.text = "0"
        self.textFieldInput.delegate = self
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.textFieldInput.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HomeViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = textField.text ?? ""
        let txtAfterUpdate = textFieldText.stringByReplacingCharactersInRange(range, withString: string)
        
        if txtAfterUpdate.characters.count > 126 {
            let alert = UIAlertController(title: "Error", message: "Value Must Less Than 126!!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
    
            return true
        }
        
        self.labelCountCharacters.text = "\(txtAfterUpdate.characters.count)"
        return true
    }
}
