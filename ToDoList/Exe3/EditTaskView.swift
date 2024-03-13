//
//  EditTaskView.swift
//  Exe3
//
//  Created by Ashot Harutyunyan on 2024-03-10.
//

import Foundation
import SwiftUI

struct EditTaskView: View {
    @State var item: TodoItem
    var onSave: (TodoItem) -> Void

    var body: some View {
        Form {
            TextField("Title", text: $item.title)
            DatePicker("Due Date", selection: $item.dueDate)
            // Add more fields as needed
        }
        .navigationTitle("Edit Task")
        .toolbar {
            Button("Save") {
                onSave(item)
            }
        }
    }
}
