//
//  LocationViewController.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 2/12/2564 BE.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let manager = LocationDataManager()
    var selectedCity: LocationItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func set(selected cell: UITableViewCell, at indexPath: IndexPath) {
        if let city = selectedCity?.city {
            let data = manager.findLocation(by: city)
            if data.isFound {
                if indexPath.row == data.position {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
            }
        }else {
            cell.accessoryType = .none
        }
    }
}

//MARK: - Private Extension
private extension LocationViewController{
    
    func initialize(){
        manager.fetch()
        title = "Select a location"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension LocationViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        
        let location = manager.locationItem(at: indexPath)
        
        cell.textLabel?.text = location.full
        
        set(selected: cell, at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            selectedCity = manager.locationItem(at: indexPath)
            tableView.reloadData()
        }
    }
    
}
