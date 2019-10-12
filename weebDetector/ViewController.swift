//
//  ViewController.swift
//  weebDetector
//
//  Created by Yaroster on 10/7/19.
//  Copyright © 2019 Yaroster. All rights reserved.
//

import Cocoa
import SwiftyXMLParser


class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = NSMakeSize(self.view.frame.size.width, self.view.frame.size.height);

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func Anime_XML_link(_ sender: Any) {
        NSWorkspace.shared.open(NSURL(string: "https://malscraper.azurewebsites.net/")! as URL)
    }
    
    @IBAction func Manga_XML_link(_ sender: Any) {
        NSWorkspace.shared.open(NSURL(string: "https://malscraper.azurewebsites.net/")! as URL)
    }
    

    @IBOutlet var anime_filename_field: NSTextField!
    
    @IBOutlet var anime_weeb_name_congratulations: NSTextField!
    
    @IBOutlet var anime_weeb_percentageLabel: NSTextField!
    
    @IBOutlet var manga_filename_field: NSTextField!
    
    @IBOutlet var manga_weeb_name_congratulations: NSTextField!
    
    @IBOutlet var manga_weeb_percentageLabel: NSTextField!
    
    
    @IBAction func anime_XML_file(_ sender: Any) {
        let dialog = NSOpenPanel();

            dialog.title                   = "Choose a .xml file";
            dialog.showsResizeIndicator    = true;
            dialog.showsHiddenFiles        = true;
            dialog.canChooseDirectories    = true;
            dialog.canCreateDirectories    = true;
            dialog.allowsMultipleSelection = false;
            dialog.allowedFileTypes        = ["xml"];

        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            if (result != nil) {
                let path = result!.path
                anime_filename_field.stringValue = path
                    do {
                        let contents = try String(contentsOfFile: path)
                        let xml = try! XML.parse(contents)
                        let weeb_name = (xml.myanimelist.myinfo.user_name.text!)
                        let weeb_totalanime = Int(xml.myanimelist.myinfo.user_total_anime.text!) ?? 1
                        let weeb_animewatching = Int(xml.myanimelist.myinfo.user_total_watching.text!) ?? 1
                        let weeb_animecompleted = Int(xml.myanimelist.myinfo.user_total_completed.text!) ?? 1
                        let weeb_planned = Int(xml.myanimelist.myinfo.user_total_plantowatch.text!) ?? 1
                        let weebpercentage = (weeb_animecompleted*100)/weeb_totalanime + (weeb_planned*weeb_animewatching/weeb_totalanime)
                        print(weebpercentage)
                        anime_weeb_name_congratulations.stringValue = "Congratulations " + weeb_name + " !"
                        anime_weeb_percentageLabel.stringValue = "You're a weeb of level: " + String(weebpercentage) + "%"
                    } catch {
                        print("This could not be loaded")
                    }
                } else {
                    print("This isn't a valid XML file")
                }
            } else {
                // User clicked on "Cancel"
                return
            }
    }
    

    @IBAction func manga_XML_file(_ sender: Any) {
        let dialog = NSOpenPanel();

            dialog.title                   = "Choose a .xml file";
            dialog.showsResizeIndicator    = true;
            dialog.showsHiddenFiles        = true;
            dialog.canChooseDirectories    = true;
            dialog.canCreateDirectories    = true;
            dialog.allowsMultipleSelection = false;
            dialog.allowedFileTypes        = ["xml"];

        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            if (result != nil) {
                let path = result!.path
                manga_filename_field.stringValue = path
                    do {
                        let contents = try String(contentsOfFile: path)
                        let xml = try! XML.parse(contents)
                        let weeb_name = (xml.myanimelist.myinfo.user_name.text!)
                        let weeb_totalmanga = Int(xml.myanimelist.myinfo.user_total_manga.text!) ?? 1
                        let weeb_mangareading = Int(xml.myanimelist.myinfo.user_total_reading.text!) ?? 1
                        let weeb_mangacompleted = Int(xml.myanimelist.myinfo.user_total_completed.text!) ?? 1
                        let weeb_planned = Int(xml.myanimelist.myinfo.user_total_plantoread.text!) ?? 1
                        let weeb_dropped = Int(xml.myanimelist.myinfo.user_total_dropped.text!) ?? 1
                        let weebpercentage = (weeb_mangacompleted*100)/weeb_totalmanga + (weeb_planned*weeb_mangareading/weeb_totalmanga) - weeb_dropped
                        print(weebpercentage)
                        manga_weeb_name_congratulations.stringValue = "Congratulations " + weeb_name + " !"
                        manga_weeb_percentageLabel.stringValue = "You're a weeb of level: " + String(weebpercentage) + "%"
                    } catch {
                        print("This could not be loaded")
                    }
                } else {
                    print("This isn't a valid XML file")
                }
            } else {
                // User clicked on "Cancel"
                return
        }
    }
    
    @IBAction func got_itbutton(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
}
