//
//  CityWeatherView.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import Foundation
import UIKit

class CityWeatherView: UIView {
    
    // MARK: - Properties
    
    var weatherData: Weather? {
        didSet {
            updateUI()
        }
    }
    
    var city: City? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Elements
    
    private var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.helveticaNeueBold, size: 52.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.helveticaNeueBold, size: 52.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherConditionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.helveticaNeue, size: 22.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weather: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarhy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupHierarhy() {
        addSubview(weather)
        addSubview(cityNameLabel)
        addSubview(temperatureLabel)
        addSubview(weatherConditionLabel)
    }
    
    // MARK: - Constraints setup
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cityNameLabel.topAnchor.constraint(equalTo: topAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.left),
            cityNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Layout.right),
            
            weather.widthAnchor.constraint(equalToConstant: Layout.size),
            weather.heightAnchor.constraint(equalToConstant: Layout.size),
            weather.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: Layout.top),
            weather.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: weather.bottomAnchor, constant: Layout.bottom),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            weatherConditionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: Layout.bottom),
            weatherConditionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    // MARK: - Update UI
    
    private func updateUI() {
        if let weatherData = weatherData {
            cityNameLabel.text = city?.name
            temperatureLabel.text = "\(weatherData.current?.temp?.toInt() ?? 0) °C"
            weather.image = IconManager.setIcon(from: weatherData.current?.weather[0].icon ?? "")
            weatherConditionLabel.text = weatherData.current?.weather[0].customDescription?.capitalizingFirstLetter()
        } else {
            cityNameLabel.text = ""
            temperatureLabel.text = ""
            weatherConditionLabel.text = ""
        }
    }
}

// MARK: -  Extension

extension CityWeatherView {
    enum Layout {
        static let top: CGFloat = 18
        static let bottom: CGFloat = 8
        static let size: CGFloat = 100
        static let left: CGFloat = 20
        static let right: CGFloat = -20
    }
}
