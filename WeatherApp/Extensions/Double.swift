//
//  Double.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import Foundation

extension Double {
    func toInt() -> Int? {
        if self >= Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}

