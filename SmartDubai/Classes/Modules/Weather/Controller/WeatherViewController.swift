//  Smart Dubai
//
//  Created by Puneet kumar  on 15/06/20.
//  Copyright © 2020 Puneet Kumar. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //var tableView = UITableView()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loader: UIActivityIndicatorView!

    
    var isForeCast : Bool = false
    var isLoader : Bool = false

    
    var viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Weather"
        
        self.view.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view.
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableView.automaticDimension
        // tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: "UsersTableViewCell")
        tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Enter City Name"
        
    }
    
    @IBAction  func CurrentLocationButtonClicked()
    {
        searchBar.resignFirstResponder();
        searchBar.text = "";
        self.viewModel.weatherArray.removeAll()
        self.viewModel.WeatherForeCastArray.removeAll()
        
        isForeCast = true
        // Find current city name
        let locationManager = LocationManager.shared()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
    }
   
}


extension WeatherViewController: LocationManagerDelegate {
    
    func sendCurrentLocation(lat: Double, lon: Double) {
        self.loader.startAnimating();

        
        self.viewModel.getForeCastWheaterData(Lat: lat, Long: lon)
        {
            DispatchQueue.main.async
                {
                    self.loader.stopAnimating();

                    self.tableView.reloadData();
            }
        }
    }
    
    
    func findCurrentCityAndCountryName(city: String, country: String) {
        
        self.loader.startAnimating();

        
        self.viewModel.getForeCastWheaterData(Lat: 12121.12, Long: 23.33232)
        {
            DispatchQueue.main.async
                {
                    self.loader.stopAnimating();

                    self.tableView.reloadData();
            }
        }
    }
    
    func fialedToFindCurrentCityNameWithError(error: Error) {
        print(error.localizedDescription)
    }
}


extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isForeCast == false)
        {
            return self.viewModel.noOfRows
        }
        else
        {
            return self.viewModel.noOfForeCastRows
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as! UsersTableViewCell
        
        if(isForeCast == false)
        {
            cell.bindCellData(self.viewModel.weatherAtIndex(index:indexPath.row))
        }
        else
        {
            cell.bindCellForecastData(self.viewModel.forecastWeatherAtIndex(index: indexPath.row))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension WeatherViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                   searchBar.resignFirstResponder()

                self.viewModel.weatherArray.removeAll()
                self.viewModel.WeatherForeCastArray.removeAll()
                self.tableView.reloadData();
               }
           }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.isLoader = false;
        searchBar.resignFirstResponder()
        isForeCast = false
        self.viewModel.weatherArray.removeAll()
        self.viewModel.WeatherForeCastArray.removeAll()
        
        guard let city = searchBar.text, !city.isEmpty else {
            
            let alert = UIAlertController(title: "Error!", message: "Enter city name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        let cities = city.components(separatedBy: ",")
        if cities.count < 3 || cities.count > 7 {
            
            let alert = UIAlertController(title: "Error!", message: "You can enter minimum 3 cities and max 7 cities", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else {
            
            for city in cities {
                
                self.viewModel.getWheaterData(strCityName: city) {_,strError in
                    

                    self.loader.startAnimating();

                                     DispatchQueue.main.async
                                         {
                                             
                                            if(strError != nil && self.isLoader == false)
                                             {
                                                self.isLoader = true;
                                                let alert = UIAlertController(title: "Error!", message: strError, preferredStyle: UIAlertController.Style.alert)
                                                          alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                          self.present(alert, animated: true, completion: nil)
                                                          
                                             }
                                             self.loader.stopAnimating();

                                             self.tableView.reloadData();
                                     }
                    
                                 }
                
            }
                
            
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
    searchBar.text = ""
    //  self.viewModel.filterUserWithName(searchBar.text)
    searchBar.resignFirstResponder()
    
    viewModel.weatherArray.removeAll()
    viewModel.WeatherForeCastArray.removeAll()
    tableView.reloadData();
    
}
}
