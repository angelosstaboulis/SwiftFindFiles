//
//  ViewController.swift
//  SwiftFindFiles
//
//  Created by Angelos Staboulis on 25/7/21.
//

import Cocoa

class ViewController: NSViewController,NSTableViewDelegate,NSTableViewDataSource {
    var files:[String]=[]
    @IBOutlet var txtHomeUser: NSTextField!
    @IBOutlet var txtFindFiles: NSTextFieldCell!
    @IBOutlet var tableColumn: NSTableColumn!
    @IBOutlet var tableView: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        setupView()
    }
    @IBAction func btnFindFiles(_ sender: Any) {
        if files.count > 0{
            files.removeAll()
        }
        do {
            files = try FileManager.default.contentsOfDirectory(atPath: txtFindFiles.stringValue)
        }
        catch{
            debugPrint("something went wrong!!!")
        }
        tableView.reloadData()
    }
    func numberOfRows(in tableView: NSTableView) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return CGFloat(200.0)
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return setupCell(row:row)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}
extension ViewController{
    func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        txtHomeUser.stringValue = FileManager.default.homeDirectoryForCurrentUser.relativePath
        txtFindFiles.stringValue = txtHomeUser.stringValue
        do {
            files = try FileManager.default.contentsOfDirectory(atPath: txtFindFiles.stringValue)
        }
        catch{
            debugPrint("something went wrong!!!")
        }
        tableView.reloadData()
        
    }
    func setupCell(row:Int)->NSView{
        let label = NSText(frame: .zero)
        label.frame = CGRect(x: 10, y: 5, width: 600, height: 180)
        if row < files.count {
            label.string = FileManager.default.homeDirectoryForCurrentUser.relativePath + "/"+files[row]
        }
        let view = NSView()
        view.addSubview(label)
        return view
    }
}
