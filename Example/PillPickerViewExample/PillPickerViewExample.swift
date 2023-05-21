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
    
    /// Required collection of items confirming to `Pill`
    /// which will be used for tracking which objects
    /// are selected
    @State private var selectedColors: [ColorPill] = []
    
    var body: some View {
        NavigationView {
            TabView {
                
                /// Example view where pills wrap to new line and only occupy
                /// necessary space
                ExampleBuilder(selectedColors: $selectedColors, content: {
                    PillPickerView(items: colorPills, selectedPills: $selectedColors)
                        .pillStackStyle(.wrap)
                })
                .tag(0)
                .navigationTitle("Wrapping pills")
                
                /// Example view where pills do not wrap to new line and occupy
                /// set amount of space horizontally and vertically
                ExampleBuilder(selectedColors: $selectedColors, content: {
                    PillPickerView(items: colorPills, selectedPills: $selectedColors)
                        .pillStackStyle(.noWrap)
                })
                .tag(1)
                .navigationTitle("Static pills")
            }
            .tabViewStyle(.page)
            .tint(.accentColor)
        }
    }
}

struct ExampleBuilder<V : View>: View {
    
    typealias ContentGenerator = () -> V
    
    @Binding var selectedColors: [ColorPill]
    
    var content: ContentGenerator
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            HStack {
                Text("Select Your Favorite Colors")
                    .font(.system(size: 26, weight: .semibold, design: .rounded))
                Spacer()
            }
            .padding(.vertical, 30)
            
            /// PillPickerView usage example
            content()
            
            Text("Selected Colors:")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.top, 30)
            
            HStack(spacing: 10) {
                ForEach(selectedColors, id: \.self) { colorPill in
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundColor(colorPill.color)
                        .frame(width: 40, height: 40)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 15)
    }
}

/// Sample model conforming to the `Pill` protocol.
/// An element must have a `title` attribute.
struct ColorPill: Pill {
    let title: String
    let color: Color
}

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
