//
//  NSManagedObject+Extensions.swift
//  CortexOfBooks
//
//  Created by Zaid Neurothrone on 2022-11-05.
//

import CoreData

extension NSManagedObject {
  func save(using context: NSManagedObjectContext) {
    CoreDataProvider.save(using: context)
  }
  
  func delete(using context: NSManagedObjectContext) {
    CoreDataProvider.delete(object: self, using: context)
  }
}
