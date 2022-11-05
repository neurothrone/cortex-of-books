//
//  BooksByReadingStatusScreen.swift
//  CortexOfBooks
//
//  Created by Zaid Neurothrone on 2022-11-05.
//

import SwiftUI

struct BooksByReadingStatusScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest private var books: FetchedResults<Book>
  
  @State private var isAddViewPresented = false
  
  private let readingStatus: ReadingStatus
  
  init(readingStatus: ReadingStatus) {
    self.readingStatus = readingStatus
    
    _books = FetchRequest(
      fetchRequest: Book.allBy(readingStatus: readingStatus),
      animation: .default
    )
  }
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(books) { book in
          Text(book.title)
        }
        .onDelete(perform: delete)
      }
      .navigationTitle(readingStatus.rawValue)
      .navigationBarTitleDisplayMode(.inline)
      .sheet(isPresented: $isAddViewPresented) {
        AddBookSheet()
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: { isAddViewPresented.toggle() }) {
            Image(systemName: "plus")
          }
        }
      }
    }
  }
}

extension BooksByReadingStatusScreen {
  private func delete(atOffsets: IndexSet) {
    guard let index = atOffsets.first else { return }
    books[index].delete(using: viewContext)
  }
}

struct BooksByReadingStatusScreen_Previews: PreviewProvider {
  static var previews: some View {
    BooksByReadingStatusScreen(readingStatus: .reading)
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
  }
}
