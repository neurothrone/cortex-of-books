//
//  Book+CoreDataClass.swift
//  CortexOfBooks
//
//  Created by Zaid Neurothrone on 2022-11-05.
//
//

import CoreData
import Foundation
import UIKit

@objc(Book)
public class Book: NSManagedObject {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
    return NSFetchRequest<Book>(entityName: String(describing: Book.self))
  }
  
  @NSManaged public var id: String
  @NSManaged public var title: String
  @NSManaged public var author: String
  @NSManaged public var createdDate: Date
  @NSManaged public var publicationDate: Date
  @NSManaged public var coverImage: UIImage?
  
  @NSManaged fileprivate var readingStatusValue: String
  var readingStatus: ReadingStatus {
    get { .init(rawValue: readingStatusValue) ?? .reading }
    set { readingStatusValue = newValue.rawValue }
  }
  
  public override func awakeFromInsert() {
    super.awakeFromInsert()
    
    id = UUID().uuidString
    createdDate = .now
  }
}

extension Book : Identifiable {}
