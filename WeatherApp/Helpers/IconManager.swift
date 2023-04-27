//
//  Icons.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import Foundation
import UIKit

class IconManager {

    static func setIcon(from iconId: String) -> UIImage {
        switch iconId {
        case "01d", "01n":
            return UIImage(named: "Sun")!

        case "02d", "02n":
            return UIImage(named: "Cloudy")!

        case "03d", "03n", "04d", "04n":
            return UIImage(named: "Clouds")!

        case "09d", "09n", "10d", "10n":
            return UIImage(named: "Rain")!

        case "11d", "11n":
            return UIImage(named: "Storm")!

        case "13d", "13n":
            return UIImage(named: "Snow")!

        case "50d", "50n":
            return UIImage(named: "Mist")!

        default:
            return UIImage(named: "Sun")!
        }
    }
}
