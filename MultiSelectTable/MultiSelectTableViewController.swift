//
//  MultiSelectTableViewController.swift
//  MultiSelectTable
//
//  Created by Michael Franken on 17/03/2017.
//  Copyright © 2017 Michael Franken. All rights reserved.
//

import UIKit

class MultiSelectTableViewController: UITableViewController {

  let toDoStore = UserDefaults(suiteName: "MultiSelectTable")
  var toDos = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.initializeToDoList()

    self.navigationItem.rightBarButtonItem = self.editButtonItem
  }

  func initializeToDoList() {
    if let defaults = self.toDoStore?.array(forKey: "toDos") as? [String] {
      self.toDos = defaults
    } else {
      self.toDos = ["Go biking", "Italian Groceries", "Fix heating", "Install dimmer", "Pick up books"]
      self.toDoStore?.set(self.toDos, forKey: "toDos")
    }
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    return UITableViewCellEditingStyle.none
  }

  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let todo = self.toDos.remove(at: sourceIndexPath.row)
    self.toDos.insert(todo, at: destinationIndexPath.row)
    self.toDoStore?.set(self.toDos, forKey: "toDos")
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toDos.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    cell.textLabel?.text = self.toDos[indexPath.row]

    return cell
  }

  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */

  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */

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

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
