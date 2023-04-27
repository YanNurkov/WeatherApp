//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import Foundation

struct Weather: Codable {
    let current: Current?
    let timezone: String?
    let daily: [Daily]?
    let hourly: [Hourly]?
}

struct Current: Codable {
    let dt: Double?
    let temp: Double?
    let weather: [WeatherConditions]
}

struct Daily: Codable {
    let dt: Double?
    let temp: Temperatures?
    let weather: [WeatherConditions]?
}

struct Hourly: Codable {
    let dt: Double
    let temp: Double?
    let weather: [WeatherConditions]?
}

struct WeatherConditions: Codable {
    let main: String?
    let customDescription: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case customDescription = "description"
        case main
        case icon
    }
}

struct Temperatures: Codable {
    let day: Double?
    let min: Double?
    let max: Double?
}

struct City {
    let name: String
}
