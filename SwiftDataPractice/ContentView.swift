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
                    .frame(height: 30)
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                Button("Add") {
                    addItem(itemName: newItemText)
                    newItemText = ""
                }
                .frame(height: 30)
                .padding(.leading, 8)
                .padding(.trailing, 8)
            }
            .padding(.top, 25)
            
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
                        HStack {
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
                            .padding(.trailing, 5)
                            .buttonStyle(.borderless)
                            
                            Button {
                                deleteItem(item: item)
                            } label: {
                                Image(systemName: "trash")

                            }
                            .buttonStyle(.borderless)
                        }
                    }
                    .padding(5)
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
