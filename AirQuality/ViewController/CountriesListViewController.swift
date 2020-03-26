//
//  CountriesListViewController.swift
//  AirQuality
//
//  Created by Hin Wong on 3/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class CountriesListViewController: UIViewController {
    
 // MARK: - Properties
     var countries: [String] = [] {
         didSet {
             updateTableView()
         }
     }

     // MARK: - Outlets
     @IBOutlet weak var tableView: UITableView!
     
     // MARK: - Lifecycle
     override func viewDidLoad() {
         super.viewDidLoad()
         tableView.delegate = self
         tableView.dataSource = self
         CityAirQualityController.fetchSupportedCountries { (countries) in
             if let countries = countries {
                 self.countries = countries
             }
         }
     }
     
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "toStatesVC" {
             guard let indexPath = tableView.indexPathForSelectedRow,
                 let destinationVC = segue.destination as? StaesListViewController
                 else { return }
             
             let selectedCountry = countries[indexPath.row]
             
             destinationVC.country = selectedCountry
         }
     }
     
     // MARK: - Class Method
     func updateTableView() {
         DispatchQueue.main.async {
             self.tableView.reloadData()
         }
     }
 }

 // MARK: - TableView DataSource/Delegate
 extension CountriesListViewController : UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return countries.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
         let country = countries[indexPath.row]
         cell.textLabel?.text = country
         return cell
     }
}
