//
//  EntryView.swift
//  Intent
//
//  Created by Claudius Ma on 10/17/24.
//
import SwiftUI
import SwiftData

struct EntryView: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.modelContext) private var context

  @FocusState private var isFocused: Bool

  @State private var userInput: String = ""

  var body: some View {


    VStack {
      Text("I'm intent to do")
        .padding(.top)
        .font(.headline)

      ZStack(alignment: .topLeading) {
        TextEditor(text: $userInput)
          .frame(minHeight: 200)
          .scrollContentBackground(.hidden)
          .padding()
      }
      .background(Color.backgroundDefaultBgplus)
      .font(.body)
      .focused($isFocused, equals: true)
      .cornerRadius(12.0)
      .padding(4)
      .onAppear {
        isFocused = true
      }

      Spacer()

      Button(action: addItem) {
        Text("Done")
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.backgroundBrandDefault)
          .foregroundColor(Color.textBrandOnBrand)
          .font(.body.bold())
          .cornerRadius(10)
      }
    }
    .padding()
    .presentationDragIndicator(.visible)
    .background(Color.backgroundDefaultBg)
  }


  private func addItem() {
    guard !userInput.isEmpty else { return }
    let item = Item(userIntent: userInput)
    context.insert(item)
    dismiss()
  }
}

#Preview {
  EntryView()
    .modelContainer(for: Item.self)
}
