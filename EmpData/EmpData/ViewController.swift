//
//  ViewController.swift
//  EmpData
//
//  Created by Reddy on 18/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var empArray = [Employee]()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Employees> = {
        let fetchRequest:NSFetchRequest<Employees> = Employees.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:#keyPath(Employees.id),ascending:true)]
        
        
            let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
     private lazy var searchResultsController: NSFetchedResultsController<Employees> = {
        let fetchRequest:NSFetchRequest<Employees> = Employees.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:#keyPath(Employees.name),ascending:true)]
        print("searching with text: \(self.searchBar.text!)")
        fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", self.searchBar.text!)
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
        tableView.isHidden = true
        self.featchEmployees()
        setupView()
        if !hasEmployees {
            print("employees count 0")
       getEmpdata()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private var hasEmployees:Bool{
        guard  let fetchedObjects = fetchedResultsController.fetchedObjects else {
            return false
        }
        return fetchedObjects.count > 0
    }
    
    private func setupView(){
        activityView.stopAnimating()
        tableView.isHidden = false
        
    }
   private func updateView(){
     tableView.isHidden = !hasEmployees
     statusLbl.isHidden = hasEmployees
    }
    
    func getEmpdata(){
        let urlString = "http://websvcdev.cleanharbors.com/MobileInventoryService/employee"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            do {
                let employeeData = try JSONDecoder().decode(EmpData.self, from: data)
                DispatchQueue.main.async {
                   print(employeeData.emplolyees.count)
                self.empArray = employeeData.emplolyees
                self.saveIncoreData()
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
    
    
    func saveIncoreData(){
        var record = 0.0
        for emp in empArray {
        let newemp = Employees(context: CoreDataManager.context)
            newemp.branch = emp.Branch
            newemp.departmentId = emp.DepartmentId
            newemp.id = emp.Id
            newemp.name = emp.Name
            newemp.payByMile = emp.PayByMile
            newemp.state = emp.State
            newemp.title = emp.Title
            newemp.username = emp.Username
            record += 1
            print("saved:","\(record)")
        }
         CoreDataManager.saveContext()
        print("import Completed")
        self.featchEmployees()
        setupView()
        
    }
    
    private func featchEmployees(){
         print("Fetching in progress")
        do {
            try self.fetchedResultsController.performFetch()
        }catch{
            print("Unable to perform Fetch Request")
            print("\(error),\(error.localizedDescription)")
        }
    }

}

extension ViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if searchActive {
            guard let sections = searchResultsController.sections  else {return 0}
            return sections.count
        }else {
           guard let sections = fetchedResultsController.sections  else {return 0}
            return sections.count
        }
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive{
            guard  let section = searchResultsController.sections?[section] else {return 0}
            return section.numberOfObjects
        }else{
            guard  let section = fetchedResultsController.sections?[section] else {return 0}
            return section.numberOfObjects
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.reuseIdentifier, for: indexPath) as? EmployeeCell else { fatalError("Unexpected Table View Cell")}
        
        if searchActive{
            let viewModel = searchResultsController.object(at: indexPath)
            cell.configure(withViewModel: viewModel)
            
        }else{
            let viewModel = fetchedResultsController.object(at: indexPath)
            cell.configure(withViewModel: viewModel)
            
        }
      
        return cell
    }
    
}

extension ViewController:NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        updateView()
    }
    
}

extension ViewController:UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if searchText.isEmpty {
            searchActive = false
             tableView.reloadData()
            return
        }
        searchActive = true
        print("searching for :\(searchText)")
        do {
            let predicate = NSPredicate(format: "name CONTAINS[c] %@ OR id contains[cd] %@",searchText,searchText)
            
            self.searchResultsController.fetchRequest.predicate = predicate
            try self.searchResultsController.performFetch()
        }catch{
            print("Unable to perform search Request")
            print("\(error),\(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
}

