//
//  Book+Extensions.swift
//  CortexOfBooks
//
//  Created by Zaid Neurothrone on 2022-11-05.
//

import CoreData

extension Book {
  static func createWith(
    title: String,
    author: String,
    publicationYear: Int,
    readingStatus: ReadingStatus,
    using context: NSManagedObjectContext
  ) {
    let book = Book(context: context)
    book.title = title
    book.author = author
    book.publicationDate = .fromYear(publicationYear)
    book.readingStatus = readingStatus
    
    book.save(using: context)
  }
  
  
  static var all: NSFetchRequest<Book> {
    let request = Book.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(keyPath: \Book.createdDate, ascending: false)]
    return request
  }
  
  static func allBy(readingStatus: ReadingStatus) -> NSFetchRequest<Book> {
    let request: NSFetchRequest<Book> = NSFetchRequest(entityName: String(describing: Book.self))
    request.sortDescriptors = [NSSortDescriptor(keyPath: \Book.createdDate, ascending: false)]
    request.predicate = NSPredicate(format: "readingStatusValue == %@", readingStatus.rawValue)
    return request
  }
}
