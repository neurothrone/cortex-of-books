//
//  CoreDataProvider.swift
//  CortexOfBooks
//
//  Created by Zaid Neurothrone on 2022-11-05.
//

import CoreData

final class CoreDataProvider {
  static let shared = CoreDataProvider()
  static var preview: CoreDataProvider = {
    let provider = CoreDataProvider(inMemory: true)
    let context = provider.container.viewContext
    
    Book.Preview.generateSamples(using: context)
    
    return provider
  }()
  
  let container: NSPersistentContainer
  
  var viewContext: NSManagedObjectContext {
    container.viewContext
  }
  
  private init(inMemory: Bool = false) {
    UIImageValueTransformer.register()
    
    container = NSPersistentContainer(name: "Entities")
    
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("❌ -> Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    container.viewContext.automaticallyMergesChangesFromParent = true
    container.viewContext.name = "viewContext"
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.undoManager = nil
    container.viewContext.shouldDeleteInaccessibleFaults = true
  }
}
