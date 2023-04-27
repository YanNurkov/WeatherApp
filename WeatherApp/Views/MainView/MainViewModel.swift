//
//  CitiesListViewModel.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import Foundation
import UIKit

class MainViewModel {
    var weather: Dynamic<Weather?> = Dynamic(nil)
    var city: Dynamic<City?> = Dynamic(nil)
    let locationService = LocationService()
    var onError: ((String) -> Void)?
    
    func getWeather() {
        locationService.getUserLocation { [weak self] coordinate, city  in
            self?.city.value = city.map { City(name: $0) }
            ApiService.fetchWeather(lat: coordinate.latitude, lon: coordinate.longitude) { [weak self] result in
                switch result {
                case .success(let weather):
                    self?.weather.value = weather
                case .failure(let error):
                    let errorMessage = error.localizedDescription
                    self?.onError?(errorMessage)
                }
            }
        }
    }
}

