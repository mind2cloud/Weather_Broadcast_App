//
//  ViewController.swift
//  WeatherBroadcast
//
//  Created by Roman Kochnev on 01.03.2018.
//  Copyright © 2018 Roman Kochnev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var wetLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearentTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func refreshbuttonPressed(_ sender: UIButton) {
        toggleActivityIndeicator(on: true)
        getCurrentWeatherData()
    }
    
    lazy var weatherManager = APIWeatherManager(apiKey: "3cc106f92eb6c158381be304b2e6f5d4")
    let coordinates = Coordinates(latitude: 40.758539, longitude: -73.982652)
    
    func toggleActivityIndeicator(on: Bool) {
        refreshButton.isHidden = on
        
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentWeatherData()
    }
    
    func getCurrentWeatherData() {
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
            self.toggleActivityIndeicator(on: false)
            switch result {
            case .Success(let currentWeather):
                self.updateUIWith(currientWeather: currentWeather)
            case .Failure(let error as NSError):
                
                let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            default: break
            }
        }
    }

    func updateUIWith(currientWeather: CurrientWeather) {
        self.imageView.image = currientWeather.icon
        self.pressureLabel.text = currientWeather.pressureString
        self.wetLabel.text = currientWeather.wetString
        self.temperatureLabel.text = currientWeather.temperatureString
        self.appearentTemperatureLabel.text = currientWeather.appearentTemperatureString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
