//
//  ViewController.swift
//  weebanalyser
//
//  Created by Yaroster on 10/7/19.
//  Copyright © 2019 Yaroster. All rights reserved.
//

import Cocoa
import SwiftyXMLParser


class ViewController: NSViewController {
    
    var publicvar_manga_total = ""
    var publicvar_manga_reading = ""
    var publicvar_manga_completed = ""
    var publicvar_manga_planned = ""
    var publicvar_manga_dropped = ""
    
    var publicvar_anime_total = ""
    var publicvar_anime_watching = ""
    var publicvar_anime_dropped = ""
    var publicvar_anime_planned = ""
    var publicvar_anime_completed = ""

    //    Declaring my Outlets for NSTextField!
    @IBOutlet var anime_filename_field: NSTextField!
    @IBOutlet var anime_weeb_name_congratulations: NSTextField!
    @IBOutlet var anime_weeb_percentageLabel: NSTextField!
    @IBOutlet var manga_filename_field: NSTextField!
    @IBOutlet var manga_weeb_name_congratulations: NSTextField!
    @IBOutlet var manga_weeb_percentageLabel: NSTextField!
    @IBOutlet var anime_browse_button: NSButton!
    @IBOutlet var manga_browse_button: NSButton!

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
    
//    Hyperlinking
    @IBAction func Anime_XML_link(_ sender: Any) {NSWorkspace.shared.open(NSURL(string: "https://malscraper.azurewebsites.net/")! as URL)}
    @IBAction func Manga_XML_link(_ sender: Any) {NSWorkspace.shared.open(NSURL(string: "https://malscraper.azurewebsites.net/")! as URL)}


//    Declaring anime_XML_file as URL and parsing the data to give a percentage and Details_NSTextField!
    @IBAction func anime_XML_file(_ sender: Any) {
        let dialog = NSOpenPanel();
            dialog.title = "Choose an anime .xml file";
            dialog.showsResizeIndicator = true;
            dialog.showsHiddenFiles = true;
            dialog.canChooseDirectories = true;
            dialog.canCreateDirectories = true;
            dialog.allowsMultipleSelection = false;
            dialog.allowedFileTypes = ["xml"];
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            if (result != nil) {
                let path = result!.path
                anime_filename_field.stringValue = path
                    do {
                        let contents = try String(contentsOfFile: path)
                        let xml = try! XML.parse(contents)
                        let name = (xml.myanimelist.myinfo.user_name.text!)
                        if xml.myanimelist.myinfo.user_total_anime.text != nil {
                        let anime_total = Int(xml.myanimelist.myinfo.user_total_anime.text!) ?? 0
                        let anime_watching = Int(xml.myanimelist.myinfo.user_total_watching.text!) ?? 0
                        let anime_completed = Int(xml.myanimelist.myinfo.user_total_completed.text!) ?? 0
                        let anime_planned = Int(xml.myanimelist.myinfo.user_total_plantowatch.text!) ?? 0
                        let anime_dropped = Int(xml.myanimelist.myinfo.user_total_dropped.text!) ?? 0
                        let weebpercentage = (anime_completed*100+anime_planned*anime_watching)/anime_total
                        print(weebpercentage)
                        anime_weeb_name_congratulations.stringValue = "Congratulations " + name + " !"
                        anime_weeb_percentageLabel.stringValue = "You're a weeb of level: " + String(weebpercentage) + "%"
                        anime_browse_button.isEnabled = false
                        publicvar_anime_total = String(anime_total)
                        publicvar_anime_dropped = String(anime_dropped)
                        publicvar_anime_planned = String(anime_planned)
                        publicvar_anime_completed = String(anime_completed)
                        publicvar_anime_watching = String(anime_watching)
                        } else {
                            let unknown_alert = NSAlert()
                            unknown_alert.messageText = "ERROR: This is not a valid Anime XML file, either try again with another file or go to the Manga section."
                            unknown_alert.addButton(withTitle: "Close")
                            unknown_alert.runModal()
                        }}catch{}} else {}}else{return}}

    @IBAction func manga_XML_file(_ sender: Any) {
        let dialog = NSOpenPanel();
            dialog.title = "Choose a manga .xml file";
            dialog.showsResizeIndicator = true;
            dialog.showsHiddenFiles = true;
            dialog.canChooseDirectories = true;
            dialog.canCreateDirectories = true;
            dialog.allowsMultipleSelection = false;
            dialog.allowedFileTypes = ["xml"];
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            if (result != nil) {
                let path = result!.path
                manga_filename_field.stringValue = path
                    do {
                        let contents = try String(contentsOfFile: path)
                        let xml = try! XML.parse(contents)
                        if xml.myanimelist.myinfo.user_total_manga.text != nil {
                            let name = (xml.myanimelist.myinfo.user_name.text!)
                            let manga_total = Int(xml.myanimelist.myinfo.user_total_manga.text!) ?? 0
                            let manga_reading = Int(xml.myanimelist.myinfo.user_total_reading.text!) ?? 0
                            let manga_completed = Int(xml.myanimelist.myinfo.user_total_completed.text!) ?? 0
                            let manga_planned = Int(xml.myanimelist.myinfo.user_total_plantoread.text!) ?? 0
                            let manga_dropped = Int(xml.myanimelist.myinfo.user_total_dropped.text!) ?? 0
                            let weebpercentage = (manga_completed*100+manga_planned*manga_reading)/(manga_total - manga_dropped)
                            manga_weeb_name_congratulations.stringValue =     "Congratulations " + name + " !"
                            manga_weeb_percentageLabel.stringValue = "You're a weeb at : " + String(weebpercentage) + "%"
                            manga_browse_button.isEnabled = false
                            publicvar_manga_total = String(manga_total)
                            publicvar_manga_reading = String(manga_reading)
                            publicvar_manga_completed = String(manga_completed)
                            publicvar_manga_planned = String(manga_planned)
                            publicvar_manga_dropped = String(manga_dropped)
                        
                        } else {
                            let unknown_alert = NSAlert()
                            unknown_alert.messageText = "ERROR: This is not a valid Manga XML file, either try again with another file or go to the Anime section."
                            unknown_alert.addButton(withTitle: "Close")
                            unknown_alert.runModal()
                        }
                    } catch {
                }
            }
        }
    }


    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "mangadetails_segue") {
            let Dvc = segue.destinationController as? DetailsViewController
            Dvc!.Details_publicvar_manga_total = publicvar_manga_total
            Dvc!.Details_publicvar_manga_reading = publicvar_manga_reading
            Dvc!.Details_publicvar_manga_completed = publicvar_manga_completed
            Dvc!.Details_publicvar_manga_planned = publicvar_manga_planned
            Dvc!.Details_publicvar_manga_dropped = publicvar_manga_dropped
        } else if (segue.identifier == "animedetails_segue") {
            let Dvc = segue.destinationController as? DetailsViewController
            Dvc!.Details_publicvar_anime_total = publicvar_anime_total
            Dvc!.Details_publicvar_anime_dropped = publicvar_anime_dropped
            Dvc!.Details_publicvar_anime_planned = publicvar_anime_planned
            Dvc!.Details_publicvar_anime_completed = publicvar_anime_completed
            Dvc!.Details_publicvar_anime_watching = publicvar_anime_watching
        }
    }
    
    @IBAction func mangadetails_segue_perform(_ sender: Any?) {
        performSegue(withIdentifier: "mangadetails_segue", sender: nil)
    }
    
    @IBAction func manga_backsegue(_ sender: Any) {
        dismiss(ViewController.self)
    }
    
    @IBAction func anime_backsegue(_ sender: Any) {
        dismiss(ViewController.self)
    }
    
    //   @IBAction for "Exit weebanalyser Button"
    @IBAction func manga_exit(_ sender: Any) {
        NSApp.miniaturizeAll(nil)
        exit(0)
    }
    @IBAction func anime_exit(_ sender: Any) {
        NSApp.miniaturizeAll(nil)
        exit(0)
    }
}
