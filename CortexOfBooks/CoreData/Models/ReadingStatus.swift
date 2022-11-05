//
//  ReadingStatus.swift
//  CortexOfBooks
//
//  Created by Zaid Neurothrone on 2022-11-05.
//

enum ReadingStatus: String {
  case reading = "Reading"
  case willRead = "Will Read"
  case haveRead = "Have Read"
}

extension ReadingStatus: Identifiable, CaseIterable, Codable {
  var id: Self { self }
}
