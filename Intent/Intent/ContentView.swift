//
//  ContentView.swift
//  Intent
//
//  Created by Claudius Ma on 10/15/24.
//
import SwiftData
import SwiftUI
import DaydreamerDesignSystem

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var showEntryView = true

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        DetailView(item: item)
                    } label: {
                        Text(item.userIntent)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { showEntryView = true }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .sheet(isPresented: $showEntryView) {
            EntryView()
        }
    }
    
    /// <#Description#>
    /// - Parameter offsets: <#offsets description#>
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

struct DetailView: View {
    let item: Item

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(item.userIntent)
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Created at: \(item.timestamp, format: .dateTime)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding()
            }
            .background(Color.white)
            .cornerRadius(12)
            .padding()
        }
        .background(Color(.systemGray6))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self)
}
