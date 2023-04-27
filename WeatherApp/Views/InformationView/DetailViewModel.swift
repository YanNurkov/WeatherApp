//
//  DetailViewModel.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import Foundation

class DetailViewModel {
    
    // MARK: - Properties
    
    var weatherData: Weather
    var city: String
    
    // MARK: - Initialization
    
    init(weatherData: Weather, city: String) {
        self.weatherData = weatherData
        self.city = city
    }
}
