//
//  CitiesListViewController.swift
//  AirQuality
//
//  Created by Hin Wong on 3/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {

    // MARK: - Properties
        var state: String?
        var country: String?
        var cities: [String] = [] {
            didSet {
                updateTableView()
            }
        }

        // MARK: - Outlets
        @IBOutlet weak var tableView: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.delegate = self
            tableView.dataSource = self
            guard let state = state,
                let country = country
                else { return }
            CityAirQualityController.fetchSupportedCities(inState: state, country: country) { (cities) in
                if let cities = cities {
                    self.cities = cities
                }
            }
        }
        
        // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toCityDetailsVC" {
                guard let indexPath = tableView.indexPathForSelectedRow,
                    let country = country,
                    let state = state,
                    let destinationVC = segue.destination as? CitiesDetailViewController
                    else { return }
                
                let selectedCity = cities[indexPath.row]
                destinationVC.city = selectedCity
                destinationVC.state = state
                destinationVC.country = country
            }
        }
        
        // MARK: - Class Methods
        func updateTableView() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return cities.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
            let city = cities[indexPath.row]
            cell.textLabel?.text = city
            return cell
        }
}
