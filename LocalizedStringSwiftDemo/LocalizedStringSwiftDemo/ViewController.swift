//
//  ViewController.swift
//  LocalizedStringSwiftDemo
//
//  Created by Kenta Nakae on 11/29/16.
//  Copyright © 2016 digitrick. All rights reserved.
//

import UIKit
import LocalizedStringSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    
    let localizedLanguage = LocalizedString.language
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        localizedLanguage.resetLanguage()
        if localizedLanguage.currentIdentifier == "ja" {
            segmentedControl.selectedSegmentIndex = 1
        } else {
            segmentedControl.selectedSegmentIndex = 0
        }
        selectLanguage(segmentedControl)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changedLanguage), name: NSNotification.Name(.localizedLanguageChanged), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changedLanguage() {
        print("Changed to \(localizedLanguage.currentDisplayName) ")
    }
    
    @IBAction func selectLanguage(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            label.text = label.text?.localized(key: "title", language: "en")
            localizedLanguage.currentIdentifier = "en"
        case 1:
            label.text = label.text?.localized(key: "title", language: "ja")
            localizedLanguage.currentIdentifier = "ja"
        default:
            return
        }
    }

}

