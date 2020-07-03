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
    
    @IBOutlet var anime_label_image: NSButton!
    @IBOutlet var manga_label_image: NSButton!
    @IBOutlet weak var manga_label_text: NSTextField!
    @IBOutlet weak var filename_field: NSTextField!
    @IBOutlet weak var percentageLabel: NSTextField!
    @IBAction func backsegue_2(_ sender: Any) {
        dismiss(ViewController.self)
    }
    @IBAction func backsegue_1(_ sender: Any) {dismiss(ViewController.self)}
    @IBAction func malretrievelink(_ sender: Any) {NSWorkspace.shared.open(NSURL(string: "https://malscraper.azurewebsites.net/")! as URL)}
    @IBAction func closebutton(_ sender: Any) {
        NSApp.miniaturizeAll(nil)
        exit(0)
    }

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
                    filename_field.stringValue = path
                        do {
                            let contents = try String(contentsOfFile: path)
                            let xml = try! XML.parse(contents)
                            if xml.myanimelist.myinfo.user_total_manga.text != nil {
                                let manga_total = Int(xml.myanimelist.myinfo.user_total_manga.text!) ?? 0
                                let manga_reading = Int(xml.myanimelist.myinfo.user_total_reading.text!) ?? 0
                                let manga_completed = Int(xml.myanimelist.myinfo.user_total_completed.text!) ?? 0
                                let manga_planned = Int(xml.myanimelist.myinfo.user_total_plantoread.text!) ?? 0
                                let manga_dropped = Int(xml.myanimelist.myinfo.user_total_dropped.text!) ?? 0
                                let weebpercentage = (manga_completed*100+manga_planned*manga_reading)/(manga_total - manga_dropped)
                                percentageLabel.stringValue = "You're a weeb at : " + String(weebpercentage) + "%"
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
    
    
    @IBAction func Anime_Label(_ sender: Any) {
        
    }
    @IBAction func Manga_Label(_ sender: Any) {
        
    }
}
