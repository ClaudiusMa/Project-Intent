//
//  DetailView.swift
//  Intent
//
//  Created by Claudius Ma on 4/6/25.
//
import SwiftUI

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
