//
//  PillPickerViewExample.swift
//  PillPickerViewExample
//
//  Created by Adis Veletanlic on 2023-05-20.
//

import SwiftUI
import PillPickerView

@main
struct PillPickerViewExample: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - Example

struct ContentView: View {
    
    /// Sample model conforming to the `Pill` protocol.
    /// An element must have a `title` attribute.
    struct ColorPill: Pill {
        let title: String
        let color: Color
    }
    
    /// Required collection of items confirming to `Pill`
    /// which will be used for tracking which objects
    /// are selected
    @State private var selectedColors: [ColorPill] = []
    
    /// Collection of items conforming to `Pill`
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
        NavigationView {
            VStack(alignment: .leading, spacing: 40) {
                Text("Select Your Favorite Colors")
                    .font(.system(size: 26, weight: .semibold, design: .rounded))
                
                /// PillPickerView usage example
                PillPickerView(items: colorPills, selectedPills: $selectedColors)
                    .pillStackStyle(StackStyle.noWrap)
                
                Text("Selected Colors:")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                
                HStack(spacing: 10) {
                    ForEach(selectedColors, id: \.self) { colorPill in
                        RoundedRectangle(cornerRadius: 40)
                            .foregroundColor(colorPill.color)
                            .frame(width: 40, height: 40)
                    }
                }
                
                Spacer()
            }
            .padding()
            .padding(.top, 15)
            .navigationTitle("PillPickerView")
        }
    }
}
