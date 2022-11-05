//
//  Date+Extensions.swift
//  CortexOfBooks
//
//  Created by Zaid Neurothrone on 2022-11-05.
//

import Foundation

extension Date {
  static func fromYear(_ year: Int) -> Date {
    var components = DateComponents()
    components.year = year
    return Calendar.current.date(from: components) ?? .now
  }
}
