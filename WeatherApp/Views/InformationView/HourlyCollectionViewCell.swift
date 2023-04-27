//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "HourlyWeatherCollectionViewCell"
    
    var hourlyWeatherData: Hourly? {
        didSet {
            setupCellDatas(from: hourlyWeatherData!)
        }
    }
    
    // MARK: - Elements
    
    private var hourLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.helveticaNeue, size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var weatherIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var temperature: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.helveticaNeue, size: 18.0)
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupHierarhy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        changeModeInterface()
    }
    
    // MARK: - UI Setup
    
    private func setupHierarhy() {
        addSubview(hourLabel)
        addSubview(weatherIcon)
        addSubview(temperature)
    }
    
    private func changeModeInterface() {
        if traitCollection.userInterfaceStyle == .dark {
            hourLabel.textColor = .white
            temperature.textColor = .white
        } else {
            hourLabel.textColor = .black
            temperature.textColor = .black
        }
    }
    
    // MARK: - Constraints Setup
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            hourLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            hourLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Layout.top),
            
            weatherIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: Layout.size),
            weatherIcon.heightAnchor.constraint(equalToConstant: Layout.size),
            
            temperature.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            temperature.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Layout.bottom)
        ])
    }
    
    // MARK: - Data Setup
    
    private func setupCellDatas(from data: Hourly) {
        let deviceTimezone = TimeZone.current.identifier
        hourLabel.text = TimeManager.getTimeFromTimestamp(timestamp: data.dt, timezone: deviceTimezone)
        weatherIcon.image = IconManager.setIcon(from: data.weather?[0].icon ?? "")
        temperature.text = "\(data.temp?.toInt() ?? 0)°"
    }
}

extension HourlyCollectionViewCell {
    enum Layout {
        static let top: CGFloat = 5
        static let bottom: CGFloat = -7
        static let size: CGFloat = 25
    }
}
