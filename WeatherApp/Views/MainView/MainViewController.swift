//
//  CitiesListViewController.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: MainViewModel
    
    // MARK: - UI Elements
    
    private var cityWeatherView: CityWeatherView = {
        let cityWeatherView = CityWeatherView()
        cityWeatherView.translatesAutoresizingMaskIntoConstraints = false
        cityWeatherView.backgroundColor = .white
        cityWeatherView.layer.cornerRadius = 20
        return cityWeatherView
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .black
        return indicator
    }()
    
    // MARK: - Initialization
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        viewModel.getWeather()
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
    
    // MARK: - UI setup
    
    private func setupUI() {
        makeGradiendBackground()
        setupHierarhy()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cityWeatherViewTapped))
        cityWeatherView.addGestureRecognizer(tapGesture)
    }
    
    private func setupHierarhy() {
        view.addSubview(cityWeatherView)
        view.addSubview(activityIndicator)
    }
    
    // MARK: - Constraints setup
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cityWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20),
            cityWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cityWeatherView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cityWeatherView.heightAnchor.constraint(equalToConstant: 300),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    // MARK: - Observers setup
    
    private func setupObservers() {
        viewModel.weather.bind(self) { [weak self] weather in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.cityWeatherView.weatherData = weather
            }
        }
        
        viewModel.city.bind(self) { [weak self] city in
            DispatchQueue.main.async {
                self?.cityWeatherView.city = city
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: "\(errorMessage) \nClicking on OK will close the application.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    exit(0)
                })
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func cityWeatherViewTapped() {
        guard let weatherData = cityWeatherView.weatherData else {
            return
        }
        let detailViewModel = DetailViewModel(weatherData: weatherData,
                                              city: viewModel.city.value?.name ?? "")
        self.navigationController?.pushViewController(DetailViewController(viewModel: detailViewModel), animated: true)
    }
}

