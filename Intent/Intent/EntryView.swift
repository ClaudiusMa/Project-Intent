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
                .font(.headline)
                .padding()
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $userInput)
                    .frame(minHeight: 200)
                    .scrollContentBackground(.hidden)
                    .padding()
            }
            .background(Color(.systemBackground))
            .font(.body)
            .focused($isFocused, equals: true)
            .cornerRadius(12.0)
            .padding(.vertical, 8)
            .onAppear {
              isFocused = true
            }
            
            Spacer()
            
            Button(action: addItem) {
                Text("Record My Intent")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.accent))
                    .foregroundColor(.white)
                    .font(.body.bold())
                    .cornerRadius(10)
            }
        }
        .padding()
        .presentationDragIndicator(.visible)
        .background(Color(UIColor.systemGray6))
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
