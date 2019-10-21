//
//  DetailsViewController.swift
//  
//
//  Created by Yaroster on 21/10/2019.
//

import Cocoa

class DetailsViewController: NSViewController {

    var myString = String()
    
    @IBOutlet var manga_reading_label: NSTextField!
    @IBOutlet var manga_dropped_label: NSTextField!
    @IBOutlet var manga_planned_label: NSTextField!
    @IBOutlet var manga_completed_label: NSTextField!
    @IBOutlet var manga_mostread_label: NSTextField!
    @IBOutlet var anime_watching_label: NSTextField!
    @IBOutlet var anime_dropped_label: NSTextField!
    @IBOutlet var anime_planned_label: NSTextField!
    @IBOutlet var anime_completed_label: NSTextField!
    @IBOutlet var anime_mostwatched_label: NSTextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
