//
//  MasterViewController.swift
//  Dark Light Mode
//
//  Created by Paul Nguyen on 3/12/19.
//  Copyright © 2019 Paul Ngyn. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil

    var pageTextColor: UIColor = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.view.backgroundColor = UIColor.clear
        self.tableView.backgroundColor = UIColor.clear
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        setUpMode()
    }
    
    
    @objc
    func insertNewObject(_ sender: Any) {
        modeConfig.nextMode()
        let context = self.fetchedResultsController.managedObjectContext
        let newEvent = Event(context: context)
        
        // If appropriate, configure the new managed object.
        let numberOfRows = self.tableView.numberOfRows(inSection: 0)
        
        newEvent.timestamp = Date()
        newEvent.swiftyspeed = 0.707*Double(numberOfRows)
        
        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this with code to handle errors appropriately
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
            let object = fetchedResultsController.object(at: indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let event = fetchedResultsController.object(at: indexPath)
        configureCell(cell, withEvent: event)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchedResultsController.managedObjectContext
            context.delete(fetchedResultsController.object(at: indexPath))
                
            do {
                try context.save()
            } catch {
                // Replace this with code to handle errors appropriately
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func configureCell(_ cell: UITableViewCell, withEvent event: Event) {
        cell.textLabel!.text = "ticket:" + event.timestamp!.euroForm_En_US + " @\(event.swiftyspeed)MPH"
        
        cell.textLabel!.textColor = pageTextColor
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController<Event> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.fetchBatchSize = 20 // Set batch size to a reasonable number
        
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false) // Edit the sort key as appropriate
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit section name key path and cache name if appropriate. nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
             // Replace this with code to handle errors appropriately
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    var _fetchedResultsController: NSFetchedResultsController<Event>? = nil

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
            case .insert:
                tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            case .delete:
                tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            default:
                return
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
            case .update:
                configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Event)
            case .move:
                configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Event)
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         tableView.reloadData()
     }
     */
    func updateModeMisc(){
        self.tableView.reloadData()
        navigationController?.navigationBar.barStyle = .black
    }
}

extension MasterViewController: ModeType {
    func applyMode(_ mode: AppMode) {
        self.view.backgroundColor = mode.backgroundColor
        
        pageTextColor = mode.textColor
        updateModeMisc() // Function to add any other UI Updates you may need
        
        print("applying master mode -----\n" +
              "bg-c: \(mode.backgroundColor.description)\n" +
              "txt-c: \(mode.textColor.description)\n" +
              "sb-sty: \(mode.statusBarStyle)")
    }
}
