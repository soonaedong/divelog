//
//  DiveLogTableViewController.swift
//  dive log
//
//  Created by max on 01/01/2019.
//  Copyright © 2019 shc. All rights reserved.
//

import UIKit
import os.log


class DiveLogTableViewController: UITableViewController {
    var logs = [DiveLog]()
    
    private func loadSampleLog() {
        guard let log1 = DiveLog(site: "first", date: Date() as Date, time: Date() as Date ) else{
            fatalError("Unable")
        }
        guard let log2 = DiveLog(site: "second", date: Date() as Date, time:Date() as Date) else{
            fatalError("Unable")
        }
        guard let log3 = DiveLog(site: "third", date: Date() as Date, time:Date() as Date) else{
            fatalError("Unable")
        }
//        guard let log2 = DiveLog(site: "Second", date: "bbb", time: "cccc") else{
//            fatalError("Unable")
//        }
//        guard let log3 = DiveLog(site: "third", date: "bbb", time: "cccc") else{
//            fatalError("Unable")
//        }
//
        logs += [log1, log2, log3]
    }
    
    
    @IBAction func unwindToDiveLogList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as?
            DiveLogViewController, let diveLog = sourceViewController.diveLog {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                logs[selectedIndexPath.row] = diveLog
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            }
            else{
                let newIndexPath = IndexPath(row: logs.count, section: 0)
            
                logs.append(diveLog)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        loadSampleLog()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return logs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DiveLogTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DiveLogTableViewCell else { fatalError("Errorrrrrr")}
    
        // Configure the cell...
        let divelog = logs[indexPath.row]
        
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let timeFormate = DateFormatter()
        timeFormate.dateFormat = "mm:ss"
        
        
        cell.siteName.text = divelog.site
        cell.diveDate.text = dateFormate.string(from: divelog.date as Date)
        cell.diveTime.text = timeFormate.string(from:divelog.time as Date)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            logs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a New Log.", log: OSLog.default, type: .debug)
            
        case "showDetail":
            guard let divelogDetailViewController = segue.destination as? DiveLogViewController
                else{
                    fatalError("Unexpected")
            }
            guard let selectedDiveLogCell = sender as? DiveLogTableViewCell else{
                fatalError("ERRORRRORR")
            }
            guard let indexPath = tableView.indexPath(for: selectedDiveLogCell) else {
                fatalError("ERRORRRORR")
            }
            
            let selectedDiveLog =  logs[indexPath.row]
            divelogDetailViewController.diveLog = selectedDiveLog
        
        default:
            fatalError("Unexpected")
        }
    }
    

}
