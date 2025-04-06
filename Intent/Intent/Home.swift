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
  // MARK: - Properties
  @Environment(\.modelContext) private var modelContext
  @Query private var items: [Item]
  @State private var showEntryView = false

  // MARK: - Body
  var body: some View {
    NavigationSplitView {
      Text("Summary")
        .font(.largeTitle.bold())
      weeklySummaryView
      todaysView
    } detail: {
      Text("Select an item")
    }
    .sheet(isPresented: $showEntryView) {
      EntryView()
    }
  }

  // MARK: - View Components
  private var weeklySummaryView: some View {
    VStack{
      Text("Weekly Summary")
        .font(.title3.bold())
      List {
        // TODOs: Top 3 frequent things
        ForEach(topThreeItems) { item in
          Text(item.userIntent)
        }
      }
    }
  }

  private var todaysView: some View {
    List {
      ForEach(items) { item in
        navigationLink(for: item)
      }
      .onDelete(perform: deleteItems)
    }
    .toolbar {
      toolbarContent
    }
  }

  private var toolbarContent: some ToolbarContent {
    Group {
      ToolbarItem(placement: .navigationBarTrailing) {
        EditButton()
      }
      ToolbarItem {
        addButton
      }
    }
  }

  private var addButton: some View {
    Button(action: { showEntryView = true }) {
      Label("Add Item", systemImage: "plus")
    }
  }

  private func navigationLink(for item: Item) -> some View {
    NavigationLink {
      DetailView(item: item)
    } label: {
      Text(item.userIntent)
    }
  }
}

// MARK: - Helper Methods
private extension ContentView {
  func deleteItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(items[index])
      }
    }
  }
}

// MARK: - Preview
#Preview {
  let mockTopThreeItems: [Item] = []

  ContentView()
    .modelContainer(for: Item.self)
}
