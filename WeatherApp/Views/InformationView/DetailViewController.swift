//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: DetailViewModel
    
    
    // MARK: - UI Elements
    
    private var city: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.helveticaNeueBold, size: 52.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var currentConditions: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.helveticaNeue, size: 22.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = IconManager.setIcon(from: viewModel.weatherData.current?.weather[0].icon ?? "")
        return imageView
    }()
    
    private var currentTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.helveticaNeueBold, size: 52.0)
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var minMaxTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.helveticaNeueBold, size: 22.0)
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var hourlyWeatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HourlyCollectionViewCell.self,
                                forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var dailyWeatherTableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: .grouped)
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        scrollView.bounces = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        setupUI()
        setupConstraints()
        setupData()
    }
    
    // MARK: - Initialization
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        changeModeInterface()
    }
    
    private func makeGradiendBackground() {
        let firstColor = UIColor.pinkBackground
        let secondColor = UIColor.blueBackground
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    // MARK: - UI setup
    
    private func setupUI() {
        makeGradiendBackground()
        changeModeInterface()
        setupNavigationController()
        setupTableViewDelegateAndDataSource()
        setupHierarhy()
    }
    
    private func setupHierarhy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(city)
        contentView.addSubview(currentConditions)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(currentTemperature)
        contentView.addSubview(minMaxTemperature)
        contentView.addSubview(hourlyWeatherCollectionView)
        contentView.addSubview(dailyWeatherTableView)
    }
    
    private func setupTableViewDelegateAndDataSource() {
        hourlyWeatherCollectionView.dataSource = self
        hourlyWeatherCollectionView.delegate = self
    }
    
    private func changeModeInterface() {
        if traitCollection.userInterfaceStyle == .dark {
            self.navigationController?.navigationBar.tintColor = .white
            city.textColor = .white
            currentConditions.textColor = .white
            currentTemperature.textColor = .white
            minMaxTemperature.textColor = .white
            dailyWeatherTableView.separatorColor = .white
        } else {
            self.navigationController?.navigationBar.tintColor = .black
            city.textColor = .black
            currentConditions.textColor = .black
            currentTemperature.textColor = .black
            minMaxTemperature.textColor = .black
            dailyWeatherTableView.separatorColor = .black
        }
    }
    // MARK: - Constraints setup
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            city.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            city.topAnchor.constraint(equalTo: contentView.topAnchor),
            city.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.leftOrBottom),
            city.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Layout.right),
            
            currentConditions.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            currentConditions.topAnchor.constraint(equalTo: city.bottomAnchor, constant: Layout.currentConditions),
            
            weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIcon.topAnchor.constraint(equalTo: city.bottomAnchor, constant: Layout.weatherIconTop),
            weatherIcon.widthAnchor.constraint(equalToConstant: Layout.weatherIconWidthHeight),
            weatherIcon.heightAnchor.constraint(equalToConstant: Layout.weatherIconWidthHeight),
            
            currentTemperature.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: Layout.topAnchor),
            currentTemperature.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            minMaxTemperature.topAnchor.constraint(equalTo: currentTemperature.bottomAnchor, constant: Layout.topAnchor),
            minMaxTemperature.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            hourlyWeatherCollectionView.topAnchor.constraint(equalTo: minMaxTemperature.bottomAnchor, constant: Layout.leftOrBottom),
            hourlyWeatherCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hourlyWeatherCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hourlyWeatherCollectionView.heightAnchor.constraint(equalToConstant: Layout.hourlyWeatherCollectionViewHeight),
            
            dailyWeatherTableView.topAnchor.constraint(equalTo: hourlyWeatherCollectionView.bottomAnchor),
            dailyWeatherTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dailyWeatherTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dailyWeatherTableView.heightAnchor.constraint(equalToConstant: CGFloat(viewModel.weatherData.daily?.count ?? 0) * 44.0),
            dailyWeatherTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Data setup
    
    private func setupData() {
        city.text = viewModel.city
        currentTemperature.text = "\(viewModel.weatherData.current?.temp?.toInt() ?? 0)°"
        minMaxTemperature.text = "Min. \(viewModel.weatherData.daily?[0].temp?.min?.toInt() ?? 0)° Max. \(viewModel.weatherData.daily?[0].temp?.max?.toInt() ?? 0)°"
        currentConditions.text = viewModel.weatherData.current?.weather[0].customDescription?.capitalizingFirstLetter() ?? ""
    }
}

// MARK: - CollectionViewDataSource

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as? HourlyCollectionViewCell
        else { return UICollectionViewCell() }
        cell.hourlyWeatherData = viewModel.weatherData.hourly?[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60.0, height: 105.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  15
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherData.daily?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier,
                                                       for: indexPath) as? DailyTableViewCell else { return UITableViewCell() }
        cell.dailyWeatherData = viewModel.weatherData.daily?[indexPath.row]
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
}

extension DetailViewController {
    enum Layout {
        static let leftOrBottom: CGFloat = 20
        static let right: CGFloat = -20
        static let weatherIconWidthHeight: CGFloat = 220
        static let topAnchor: CGFloat = 10
        static let hourlyWeatherCollectionViewHeight: CGFloat = 105
        static let weatherIconTop: CGFloat = 40
        static let currentConditions: CGFloat = 5
    }
}
