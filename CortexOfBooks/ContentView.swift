//
//  ContentView.swift
//  CortexOfBooks
//
//  Created by Zaid Neurothrone on 2022-11-04.
//

import SwiftUI

private extension ReadingStatus {
  var systemImage: String {
    switch self {
    case .reading:
      return "book.fill"
    case .willRead:
      return "bookmark.fill"
    case .haveRead:
      return "book.closed.fill"
    }
  }
}

struct ContentView: View {
  @AppStorage("readingStatus")
  var readingStatus: ReadingStatus = .reading
  
  var body: some View {
    TabView(selection: $readingStatus) {
      Group {
        ForEach(ReadingStatus.allCases) { status in
          BooksByReadingStatusScreen(readingStatus: status)
            .tabItem {
              Label(status.rawValue, systemImage: status.systemImage)
            }
        }
        .toolbar(.visible, for: .tabBar)
        .toolbarBackground(.ultraThinMaterial, for: .tabBar)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
