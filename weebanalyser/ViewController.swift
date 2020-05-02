//  ViewController.swift
//  weebanalyser
//  Created by Yaroster on 10/7/19.

import Cocoa
import SwiftyXMLParser
import SwiftyJSON
import CustomSegue

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = NSMakeSize(self.view.frame.size.width, self.view.frame.size.height);
//    Do any additional setup after loading the view
    }
    override var representedObject: Any? {
        didSet {
//        Update the view, if already loaded.
        }
    }
}
