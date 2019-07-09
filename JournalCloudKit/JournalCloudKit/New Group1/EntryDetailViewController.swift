//
//  EntryDetailViewController.swift
//  JournalCloudKit
//
//  Created by Julia Rodriguez on 7/8/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    // entry landing pad
    var entry: Entry? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    @IBOutlet weak var titelTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    func updateViews() {
        guard let entry = entry else { return }
        titelTextField.text = entry.title
        bodyTextView.text = entry.bodyText
    }
    
    @IBAction func mainViewTapped(_ sender: Any) {
        bodyTextView.resignFirstResponder()
        titelTextField.resignFirstResponder()
        
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titelTextField.text = ""
        bodyTextView.text = ""
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titelTextField.text, title != "",
            let body = bodyTextView.text, body != "" else { return }
        EntryController.sharedInstance.addEntryWith(title: title, body: body) { (true) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
}
extension EntryDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true

    }
}
