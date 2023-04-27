//
//  String.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

