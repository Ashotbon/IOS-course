////
////  ContentView.swift
////  Exe3
////
////  Created by Ashot Harutyunyan on 2024-03-10.
////
//
//import SwiftUI
//
//// Define a simple model for your to-do items
//struct TodoItem: Identifiable {
//    let id: UUID
//    var title: String
//    var dueDate: Date
//    var isDone: Bool
//    
//    init(id: UUID = UUID(), title: String, dueDate: Date = Date(), isDone: Bool = false) {
//        self.id = id
//        self.title = title
//        self.dueDate = dueDate
//        self.isDone = isDone
//    }
//}
//
//// Create a view model to manage the list of to-do items
//class TodoListViewModel: ObservableObject {
//    @Published var items: [TodoItem] = [
//        TodoItem(title: "Buy milk 2%"),
//        TodoItem(title: "Wash the car"),
//        TodoItem(title: "Implement this app"),
//        TodoItem(title: "Prepare for the midterm")
//    ]
//    
//    // Function to add a new item to the list
//    func addItem(_ item: TodoItem) {
//            items.append(item)
//        }
//    
//    // Function to delete an item from the list
//    func deleteItem(at offsets: IndexSet) {
//        items.remove(atOffsets: offsets)
//    }
//}
//
//// Define your SwiftUI view for the to-do list
//struct TodoListView: View {
//    @StateObject var viewModel = TodoListViewModel()
//    @State private var searchText = ""
//    @State private var showingAddTaskView = false
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(searchResults) { item in
//                    Text(item.title)
//                }
//                .onDelete(perform: viewModel.deleteItem)
//            }
//            .navigationTitle("Todo Items")
//            .searchable(text: $searchText)
//            .toolbar {
//                            ToolbarItem(placement: .navigationBarTrailing) {
//                                Button(action: {
//                                    self.showingAddTaskView = true
//                                }) {
//                                    Image(systemName: "plus")
//                    }
//                }
//            }
//            .sheet(isPresented: $showingAddTaskView) {
//                EditAddTaskView(isPresented: $showingAddTaskView, viewModel: viewModel)
//            }
//        }
//    }
//
//    // Computed property to filter the list as per the search text
//    var searchResults: [TodoItem] {
//        if searchText.isEmpty {
//            return viewModel.items
//        } else {
//            return viewModel.items.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
//        }
//    }
//}
//


//
//  ContentView.swift
//  Exe3
//
//  Created by Ashot Harutyunyan on 2024-03-10.
//

import SwiftUI

// Define a simple model for your to-do items
struct TodoItem: Identifiable, Codable {
    let id: UUID
    var title: String
    var dueDate: Date
    var isDone: Bool
    
    
    init(id: UUID = UUID(), title: String, dueDate: Date = Date(), isDone: Bool = false) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.isDone = isDone
    }
}

// Create a view model to manage the list of to-do items
class TodoListViewModel: ObservableObject {
    @Published var items: [TodoItem] = []

    
    
    init() {
            loadFromFile()
        }

    // to add a new item to the list
    func addItem(_ item: TodoItem) {
        items.append(item)
        saveToFile()
    }
    
    func updateItem(_ item: TodoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
            saveToFile()
        }
    }
    
    // to delete an item from the list
    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        saveToFile()
    }
    
    func saveToFile() {
         guard let data = try? JSONEncoder().encode(items) else {
             print("Error: Unable to encode todo list to JSON")
             return
         }

         guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
             print("Error: Unable to locate documents directory")
             return
         }

         let fileURL = documentsDirectory.appendingPathComponent("todoList.json")

         do {
             try data.write(to: fileURL)
             print("Saved todo list to \(fileURL)")
         } catch {
             print("Error: Unable to save todo list to file: \(error.localizedDescription)")
         }
     }
    
    func loadFromFile() {
           guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
               print("Error: Unable to locate documents directory")
               return
           }

           let fileURL = documentsDirectory.appendingPathComponent("todoList.json")

           do {
               let data = try Data(contentsOf: fileURL)
               items = try JSONDecoder().decode([TodoItem].self, from: data)
           } catch {
               print("Error: Unable to load todo list from file: \(error.localizedDescription)")
           }
       }
}


struct TodoListView: View {
    @StateObject var viewModel = TodoListViewModel()
    @State private var searchText = ""
    @State private var showingAddTaskView = false
    @State private var itemBeingEdited: TodoItem?
    @State private var showingEditSheet = false
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults) { item in
                    HStack {
                        if item.isDone {
                           Image(systemName: "checkmark.circle.fill")
                           .foregroundColor(.green)
                           }
                        Text(item.title)
                        Spacer()
                        Menu {
                            Button("Modify", action: {
                                itemBeingEdited = item
                                showingAddTaskView = true
                            })
                            Button("Delete", action: {
                                // Find the index of the item and delete it
                                if let index = viewModel.items.firstIndex(where: { $0.id == item.id }) {
                                    viewModel.deleteItem(at: IndexSet(integer: index))
                                }
                            })
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .foregroundColor(.gray)
                        }
                    }
                }

                .onDelete(perform: viewModel.deleteItem)
            }
            .navigationTitle("Todo Items")
            .searchable(text: $searchText)
            .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    self.showingAddTaskView = true
                            
                                    
                                }) {
                                    Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTaskView) {
                EditAddTaskView(isPresented: $showingAddTaskView, viewModel: viewModel, itemToEdit: itemBeingEdited)
            }
        }
    }

    // Computed property to filter the list as per the search text
    var searchResults: [TodoItem] {
        if searchText.isEmpty {
            return viewModel.items
        } else {
            return viewModel.items.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

