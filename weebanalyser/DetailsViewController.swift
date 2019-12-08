//
//  DetailsViewController.swift
//  
//
//  Created by Yaroster on 21/10/2019.
//

import Cocoa

class DetailsViewController: NSViewController {

    var Details_publicvar_manga_total = ""
    var Details_publicvar_manga_reading = ""
    var Details_publicvar_manga_completed = ""
    var Details_publicvar_manga_planned = ""
    var Details_publicvar_manga_dropped = ""
    
    var Details_publicvar_anime_total = ""
    var Details_publicvar_anime_watching = ""
    var Details_publicvar_anime_dropped = ""
    var Details_publicvar_anime_planned = ""
    var Details_publicvar_anime_completed = ""
    
    @IBOutlet var manga_reading_label: NSTextField!
    @IBOutlet var manga_dropped_label: NSTextField!
    @IBOutlet var manga_planned_label: NSTextField!
    @IBOutlet var manga_completed_label: NSTextField!
    
    @IBOutlet var anime_watching_label: NSTextField!
    @IBOutlet var anime_dropped_label: NSTextField!
    @IBOutlet var anime_planned_label: NSTextField!
    @IBOutlet var anime_completed_label: NSTextField!
    
    @IBAction func helpbutton(_ sender: Any) {
        NSWorkspace.shared.open(NSURL(string: "https://gist.github.com/Yaroster/919f150d54d8da5405000de5b511e23b")! as URL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Details_publicvar_manga_total != "" {
        manga_reading_label.stringValue = String(Details_publicvar_manga_reading)
        manga_dropped_label.stringValue = String(Details_publicvar_manga_dropped)
        manga_planned_label.stringValue = String(Details_publicvar_manga_planned)
        manga_completed_label.stringValue = String(Details_publicvar_manga_completed)
        } else if Details_publicvar_anime_total != "" {
        anime_watching_label.stringValue = String(Details_publicvar_anime_watching)
        anime_dropped_label.stringValue = String(Details_publicvar_anime_dropped)
        anime_planned_label.stringValue = String(Details_publicvar_anime_planned)
        anime_completed_label.stringValue = String(Details_publicvar_anime_completed)
        }
    }
    
}
