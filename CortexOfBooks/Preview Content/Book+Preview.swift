//
//  Book+Preview.swift
//  CortexOfBooks
//
//  Created by Zaid Neurothrone on 2022-11-05.
//

import CoreData

extension Book {
  enum Preview {
    static func generateSamples(using context: NSManagedObjectContext) {
      Book.createWith(title: "Dune", author: "Frank Herbert", publicationYear: 1965, readingStatus: .haveRead, using: context)
      
      Book.createWith(title: "Dune Messiah", author: "Frank Herbert", publicationYear: 1969, readingStatus: .haveRead, using: context)
      
      Book.createWith(title: "Children of Dune", author: "Frank Herbert", publicationYear: 1976, readingStatus: .reading, using: context)
      
      Book.createWith(title: "God Emperor of Dune", author: "Frank Herbert", publicationYear: 1981, readingStatus: .willRead, using: context)
      
      Book.createWith(title: "Heretics of Dune", author: "Frank Herbert", publicationYear: 1984, readingStatus: .willRead, using: context)
    }
  }
}
