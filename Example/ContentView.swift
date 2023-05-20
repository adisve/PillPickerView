//
//  ContentView.swift
//  Example
//
//  Created by Adis Veletanlic on 2023-05-20.
//

import SwiftUI
import PillPickerView

struct ContentView: View {
    // Sample model conforming to the `Pill` protocol
    struct ColorPill: Pill {
        let title: String
        let color: Color
    }
    
    @State private var selectedColors: [ColorPill] = []
    
    let colorPills: [ColorPill] = [
        ColorPill(title: "Red", color: .red),
        ColorPill(title: "Green", color: .green),
        ColorPill(title: "Blue", color: .blue),
        ColorPill(title: "Yellow", color: .yellow),
        ColorPill(title: "Orange", color: .orange),
        ColorPill(title: "Purple", color: .purple),
        ColorPill(title: "Pink", color: .pink),
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select Your Favorite Colors")
                .font(.title)
            
            // PillPickerView usage example
            PillPickerView(
                items: colorPills,
                pillHighlightBackgroundColor: .blue,
                pillHighlightForegroundColor: .white,
                pillBackgroundColor: .secondary,
                pillForegroundColor: .white,
                selectedItemsProvider: $selectedColors
            )
            
            // Display selected colors
            Text("Selected Colors:")
                .font(.headline)
            HStack(spacing: 10) {
                ForEach(selectedColors, id: \.self) { colorPill in
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(colorPill.color)
                        .frame(width: 40, height: 40)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
