//
//  TimeManager.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import Foundation

class TimeManager {
    static func getTimeFromTimestamp(timestamp: Double, timezone: String) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: timezone)
        dateFormatter.locale = Locale.autoupdatingCurrent
        let localDate = dateFormatter.string(from: date)
        print(localDate)

        return localDate
    }

    static func getWeekDayFromTimestamp(timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekDayString = dateFormatter.string(from: date)

        return weekDayString
    }
}
