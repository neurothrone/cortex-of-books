//
//  AddBookSheet.swift
//  CortexOfBooks
//
//  Created by Zaid Neurothrone on 2022-11-05.
//

import SwiftUI

struct AddBookSheet: View {
  private enum Field {
    case title, author, publicationYear
  }
  
  @Environment(\.dismiss) private var dismiss
  @Environment(\.managedObjectContext) private var viewContext
  
  @FocusState private var focusedField: Field?
  
  @State private var title = ""
  @State private var author = ""
  @State private var publicationYear = ""
  @State private var readingStatus: ReadingStatus = .reading
  
  private var isInputValid: Bool {
    guard title.isNotEmpty,
          author.isNotEmpty,
          publicationYear.isNotEmpty,
          let year = Int(publicationYear),
          year > 0
    else { return false }
    return true
  }
  
  var body: some View {
    NavigationStack {
      content
        .padding()
        .navigationTitle("Add Book")
        .navigationBarTitleDisplayMode(.inline)
    }
  }
  
  private var content: some View {
    VStack {
      Group {
        Group {
          TextField("Title", text: $title)
            .focused($focusedField, equals: .title)
            .submitLabel(.next)
          
          TextField("Author", text: $author)
            .focused($focusedField, equals: .author)
            .submitLabel(.next)
        }
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.sentences)
        
        TextField("Publication Year", text: $publicationYear)
          .focused($focusedField, equals: .publicationYear)
          .submitLabel(.done)
          .keyboardType(.numberPad)
      }
      .textFieldStyle(.roundedBorder)
      
      Picker("Reading status", selection: $readingStatus) {
        ForEach(ReadingStatus.allCases) { status in
          Text(status.rawValue)
        }
      }
      .pickerStyle(.segmented)
      
      Spacer()
      
      Button(action: addBook) {
        Text("Save")
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
      }
      .buttonStyle(.borderedProminent)
      .padding(.top)
      .disabled(!isInputValid)
    }
    .onSubmit {
      switch focusedField {
      case .title:
        focusedField = .author
      case .author:
        focusedField = .publicationYear
      default:
        focusedField = nil
      }
    }
    .toolbar {
      ToolbarItemGroup(placement: .keyboard) {
        Spacer()
        Button(action: { focusedField = nil }) {
          Text("Dismiss")
        }
      }
    }
  }
}

extension AddBookSheet {
  private func addBook() {
    Book.createWith(
      title: title,
      author: author,
      publicationYear: Int(publicationYear) ?? .zero,
      readingStatus: readingStatus,
      using: viewContext
    )
    
    dismiss()
  }
}

struct AddBookSheet_Previews: PreviewProvider {
  static var previews: some View {
    AddBookSheet()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
  }
}
