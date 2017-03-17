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
  var hiddenToDos = Set<String>()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.initializeToDoList()

    self.navigationItem.rightBarButtonItem = self.editButtonItem
    self.tableView.allowsMultipleSelectionDuringEditing = true
  }

  func initializeToDoList() {
    if let defaults = self.toDoStore?.array(forKey: "toDos") as? [String] {
      self.toDos = defaults
    } else {
      self.toDos = ["Go biking", "Italian Groceries", "Fix heating", "Install dimmer", "Pick up books"]
      self.toDoStore?.set(self.toDos, forKey: "toDos")
    }
    if let hiddenToDoFromStore = self.toDoStore?.array(forKey: "hidden") as? [String] {
      self.hiddenToDos = Set<String>(hiddenToDoFromStore)
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
    var nrOfRows = self.toDos.count
    if !self.isEditing {
      nrOfRows -= self.hiddenToDos.count
    }
    return nrOfRows
  }

  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    tableView.setEditing(editing, animated: true)

    self.tableView.reloadData()
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    if self.isEditing {
      cell.textLabel?.text = self.toDos[indexPath.row]
      if !self.hiddenToDos.contains(self.toDos[indexPath.row]) {
        self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
      }
      let bgColorView = UIView()
      bgColorView.backgroundColor = UIColor.white
      cell.selectedBackgroundView = bgColorView
    } else {
      let todosWithHiddenItemsSkipped = self.toDos.filter { todo in
        !self.hiddenToDos.contains(todo)
      }
      cell.textLabel?.text = todosWithHiddenItemsSkipped[indexPath.row]
    }

    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.hiddenToDos.remove(self.toDos[indexPath.row])
    self.toDoStore?.set(Array(self.hiddenToDos), forKey: "hidden")
  }

  override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    self.hiddenToDos.insert(self.toDos[indexPath.row])
    self.toDoStore?.set(Array(self.hiddenToDos), forKey: "hidden")
  }
}
