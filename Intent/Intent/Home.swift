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
    ZStack {
      Color.backgroundDefaultBg.edgesIgnoringSafeArea(.all)
      NavigationStack {
        VStack{
          weeklySummaryView
          todaysView
        }
        .padding(.horizontal, Spacing.s400)
        .navigationTitle("Summary")
        .background(Color.backgroundDefaultBg)
      }
      .sheet(isPresented: $showEntryView) {
        EntryView()
      }
    }
  }

  // MARK: - View Components
  private var weeklySummaryView: some View {
    VStack{
      Text("Top 3 This week")
        .font(.title3.bold())
        .foregroundStyle(Color.textBrandSecondary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, Spacing.s100)
      List {
        // TODOs: Top 3 frequent things
        // ForEach(topThreeItems) { item in
        //     Text(item.userIntent)
        // }
      }
      .cornerRadius(Radius.r300)
      .listStyle(.plain)
      .fixedSize(horizontal: false, vertical: true)
    }
  }

  private var todaysView: some View {
    VStack{
      Text("Today")
        .font(.title3.bold())
        .foregroundStyle(Color.textBrandSecondary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, Spacing.s100)
      List {
        ForEach(items) { item in
          navigationLink(for: item)
        }
        .onDelete(perform: deleteItems)
      }
      .listStyle(.plain)
      .cornerRadius(Radius.r300)
//      .swipeActions(edge: .trailing) {
//        deleteButton
//      }
    }
  }

  private var deleteButton: some View{
    Button(action: {
      // TODOs: add delete
    }) {
      Text("Delete")
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
//  let mockTopThreeItems: [Item] = []

  ContentView()
    .modelContainer(for: Item.self)
}
