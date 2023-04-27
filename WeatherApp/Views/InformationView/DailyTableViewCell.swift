//
//  DailyTableViewCell.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "DailyTableViewCell"
    
    var dailyWeatherData: Daily? {
        didSet {
            setupCellDatas(from: dailyWeatherData!)
        }
    }
    
    // MARK: - UI Elements
    
    private var weekday: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.helveticaNeue, size: 18.0)
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var maxTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.helveticaNeueBold, size: 18.0)
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var minTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.helveticaNeue, size: 18.0)
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        addSubview(weekday)
        addSubview(weatherIcon)
        addSubview(maxTemperature)
        addSubview(minTemperature)
    }
    
    private func changeModeInterface() {
        if traitCollection.userInterfaceStyle == .dark {
            weekday.textColor = .white
            maxTemperature.textColor = .white
            minTemperature.textColor = .white
        } else {
            weekday.textColor = .black
            maxTemperature.textColor = .black
            minTemperature.textColor = .black
        }
    }
    
    // MARK: - Constraints Setup
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weekday.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            weekday.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Layout.left),
            
            weatherIcon.widthAnchor.constraint(equalToConstant: Layout.size),
            weatherIcon.heightAnchor.constraint(equalToConstant: Layout.size),
            weatherIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            maxTemperature.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            maxTemperature.rightAnchor.constraint(equalTo: self.rightAnchor, constant: Layout.bigRight),
            minTemperature.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            minTemperature.rightAnchor.constraint(equalTo: self.rightAnchor, constant: Layout.right)
        ])
    }
    
    // MARK: - Data Setup
    
    private func setupCellDatas(from data: Daily) {
        weekday.text = TimeManager.getWeekDayFromTimestamp(timestamp: data.dt ?? 0)
        weatherIcon.image = IconManager.setIcon(from: data.weather?[0].icon ?? "")
        maxTemperature.text = "\(data.temp?.max?.toInt() ?? 0)°"
        minTemperature.text = "\(data.temp?.min?.toInt() ?? 0)°"
    }
}

extension DailyTableViewCell {
    enum Layout {
        static let left: CGFloat = 25
        static let right: CGFloat = -25
        static let bigRight: CGFloat = -75
        static let size: CGFloat = 25
    }
}
