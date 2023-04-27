//
//  ApiService.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import Foundation

class ApiService {
    private static let apiUrl = "https://api.openweathermap.org/data/2.5/onecall?"
    private static let key = "34911b62733b8414cf89b7a25783adf5"
    static func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<Weather, Error>) -> Void) {
        guard let url = URL(string: "\(apiUrl)lat=\(lat)&lon=\(lon)&units=metric&exclude=minutely,alerts&appid=\(key)") else {
            completion(.failure(NSError(domain: "com.example.weatherapp", code: 1, userInfo: [NSLocalizedDescriptionKey: ErrorsDescription.invalidUrl])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "com.example.weatherapp", code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorsDescription.noData])))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let weatherData = try jsonDecoder.decode(Weather.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum ErrorsDescription {
    static let noData = "No data returned"
    static let invalidUrl = "Invalid URL"
}
