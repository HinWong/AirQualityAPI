//
//  StaesListViewController.swift
//  AirQuality
//
//  Created by Hin Wong on 3/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class StaesListViewController: UIViewController {

    // MARK: - Properties
        var country: String?
        var states: [String] = [] {
            didSet {
                updateTableView()
            }
        }

        // MARK: - Outlets
        @IBOutlet weak var tableView: UITableView!
        
        // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate = self
            guard let country = country else { return }
            CityAirQualityController.fetchSupportedStates(inCountry: country) { (states) in
                if let states = states {
                    self.states = states
                }
            }
        }

        // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toCitiesVC" {
                guard let indexPath = tableView.indexPathForSelectedRow,
                    let country = country,
                    let destinationVC = segue.destination as? CitiesListViewController
                    else { return}
                let selectedState = states[indexPath.row]
                destinationVC.country = country
                destinationVC.state = selectedState
            }
        }
        
        // MARK: - Class Methods
        func updateTableView() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    extension StaesListViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return states.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
            let state = states[indexPath.row]
            cell.textLabel?.text = state
            return cell
        }
    


}
