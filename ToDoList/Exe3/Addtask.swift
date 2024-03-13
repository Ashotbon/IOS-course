//
//  Addtask.swift
//  Exe3
//
//  Created by Ashot Harutyunyan on 2024-03-10.
//
//
//import SwiftUI
//
//struct EditAddTaskView: View {
//    @Binding var isPresented: Bool
//    @State private var taskDescription: String = ""
//    @State private var dueDate = Date()
//    @State private var taskDone: Bool = false
//    var viewModel: TodoListViewModel // Pass the viewModel to this view
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Task description")) {
//                    TextField("Enter task description", text: $taskDescription)
//                }
//
//                Section(header: Text("Due Date")) {
//                                    DatePicker(
//                                        "Due Date",
//                                        selection: $dueDate,
//                                        displayedComponents: .date
//                                    )
//                                    .datePickerStyle(WheelDatePickerStyle())
//                                }
//
//                Toggle(isOn: $taskDone) {
//                    Text("Task done ?")
//                }
//
//                Button("Save changes / Add to list") {
//                            // Create a new TodoItem and add it to the list
//                            let newItem = TodoItem(title: self.taskDescription)
//                            viewModel.addItem(newItem)
//                            self.isPresented = false
//                        }
//                        .foregroundColor(.blue)
//
//                Button("Delete (only when editing, w/ conf. dlg)") {
//                    // Here you should add the logic to confirm and delete the task
//                    isPresented = false // Dismiss the view after deleting
//                }
//                .foregroundColor(.red)
//            }
//            .navigationTitle("Adding a new task")
//            .navigationBarItems(leading: Button(action: {
//                isPresented = false // Dismiss the view when cancel is tapped
//            }) {
//                Text("Cancel")
//            })
//        }
//    }
//}



import SwiftUI

struct EditAddTaskView: View {
    
    @Binding var isPresented: Bool
    @State private var taskDescription: String = ""
    @State private var dueDate = Date()
    @State private var taskDone: Bool = false
    var viewModel: TodoListViewModel // Pass the viewModel to this view
    var itemToEdit: TodoItem? // Optional item to edit

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task description")) {
                    TextField("Enter task description", text: $taskDescription)
                }

                Section(header: Text("Due Date")) {
                    DatePicker(
                        "Due Date",
                        selection: $dueDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                }

                Toggle(isOn: $taskDone) {
                    Text("Task done ?")
                }

//                Button("Save changes / Add to list") {
//                    let newItem = TodoItem(id: itemToEdit?.id ?? UUID(), title: taskDescription, dueDate: dueDate, isDone: taskDone)
////                    if let itemToEdit = itemToEdit {
////                        viewModel.updateItem(newItem)
////                    } else {
////                        viewModel.addItem(newItem)
////                    }
//                    resetState()
//                    isPresented = false
//                }
                
                Button("Save changes / Add to list") {
                    let newItem = TodoItem(id: itemToEdit?.id ?? UUID(), title: taskDescription, dueDate: dueDate, isDone: taskDone)
                    if let itemToEdit = itemToEdit {
                        viewModel.updateItem(newItem)
                    } else {
                        viewModel.addItem(newItem)
                    }
                    resetState()
                    isPresented = false
                }
                
                .foregroundColor(.blue)

                if itemToEdit != nil {
                    Button("Delete (only when editing, w/ conf. dlg)") {
                        if let index = viewModel.items.firstIndex(where: { $0.id == itemToEdit!.id }) {
                            viewModel.deleteItem(at: IndexSet(integer: index))
                        }
                        resetState()
                        isPresented = false // Dismiss the view after deleting
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle(itemToEdit == nil ? "Adding a new task" : "Editing task")
            .navigationBarItems(leading: Button(action: {
                resetState()
                isPresented = false // Dismiss the view when cancel is tapped
            }) {
                Text("Cancel")
            })
            .onAppear {
                if let itemToEdit = itemToEdit {
                    taskDescription = itemToEdit.title
                    dueDate = itemToEdit.dueDate
                    taskDone = itemToEdit.isDone
                }
            }
        }
    }

    // Function to reset the state variables to their default values
    private func resetState() {
        taskDescription = ""
        dueDate = Date()
        taskDone = false
    }
}
