//
//  ContentView.swift
//  SwiftDataPractice
//
//  Created by Onur Altintas on 29.06.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.createdDate, order: .reverse) private var items: [Item]
    @State private var newItemText: String = ""
    @State private var editingItem: Item? = nil
    @State private var editingText: String = ""

    var body: some View {
        VStack {
            HStack {
                TextField("Enter new item", text: $newItemText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Add") {
                    addItem(itemName: newItemText)
                    newItemText = ""
                }
            }
            .padding()
            
            List {
                ForEach(items) { item in
                    HStack {
                        if editingItem?.id == item.id {
                            TextField("Edit Name", text: $editingText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        } else {
                            Text(item.name)
                        }
                        Spacer()
                        Button {
                            if editingItem?.id == item.id {
                                updateItem(item: item, itemName: editingText)
                                editingItem = nil
                                editingText = ""
                            } else {
                                editingItem = item
                                editingText = item.name
                            }
                        } label: {
                            Image(systemName: editingItem?.id == item.id ? "checkmark" : "pencil")
                        }
                        .padding(.leading, 5)
                        .buttonStyle(.borderless)
                        
                        Button {
                            deleteItem(item: item)
                        } label: {
                            Image(systemName: "trash")

                        }
                        .buttonStyle(.borderless)

                    }
                    .contentShape(Rectangle()) // sadece görünümü tanımlar
                    .padding(4)
                }
                .onDelete(perform: deleteItems)
            }
            
        }
    }

    private func addItem(itemName: String) {
        guard !itemName.isEmpty else { return }
        withAnimation {
            let newItem = Item(name: itemName)
            modelContext.insert(newItem)
        }
    }
    
    private func updateItem(item: Item, itemName: String) {
        item.name = itemName
    }
    
    private func deleteItem(item: Item) {
        withAnimation {
            modelContext.delete(item)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

/*
#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
*/
