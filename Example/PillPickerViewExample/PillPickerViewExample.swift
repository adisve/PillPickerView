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
    @State private var selectedGenres: [Genre] = []
    
    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    
                    /// Example view where pills wrap to new line and only occupy
                    /// necessary space
                    ExampleBuilder(selectedItems: $selectedGenres, content: {
                        PillPickerView(items: genres, selectedPills: $selectedGenres)
                            .pillStackStyle(.wrap)
                    })
                    .tag(0)
                    .navigationTitle("Wrapping pills")
                    
                    /// Example view where pills do not wrap to new line and occupy
                    /// set amount of space horizontally and vertically
                    ExampleBuilder(selectedItems: $selectedGenres, content: {
                        PillPickerView(items: genres, selectedPills: $selectedGenres)
                            .pillStackStyle(.noWrap)
                    })
                    .tag(1)
                    .navigationTitle("Static pills")
                }
                .tabViewStyle(.page)
                .tint(.accentColor)
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        withAnimation {
                            selectedGenres.removeAll()
                        }
                    }, label: {
                        Text("Clear All")
                    })
                })
            })
        }
    }
}

struct ExampleBuilder<T, V>: View where T: Pill, V: View {
    
    typealias ContentGenerator = () -> V
    
    @Binding var selectedItems: [T]
    
    var content: ContentGenerator
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            HStack {
                Text("Select Your Favorite Genres")
                    .font(.system(size: 26, weight: .semibold, design: .rounded))
                Spacer()
            }
            .padding(.vertical, 30)
            
            /// PillPickerView usage example
            content()
            
            Text("Selected Genres:")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.top, 30)
            
            VStack(spacing: 10) {
                ForEach(selectedItems, id: \.self) { item in
                    HStack {
                        Text(item.title)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.accentColor)
                    )
                }
            }
            .padding(.bottom, 60)
            
            Spacer()
        }
        .padding(.horizontal, 15)
    }
}

/// Sample model conforming to the `Pill` protocol.
/// An element must have a `title` attribute.
struct Genre: Pill {
    let title: String
}

/// Collection of items conforming to `Pill`
let genres: [Genre] = [
    Genre(title: "Action"),
    Genre(title: "Adventure"),
    Genre(title: "Comedy"),
    Genre(title: "Drama"),
    Genre(title: "Fantasy"),
    Genre(title: "Horror"),
    Genre(title: "Mystery"),
    Genre(title: "Romance"),
    Genre(title: "Sci-Fi"),
    Genre(title: "Thriller"),
    Genre(title: "Western"),
    Genre(title: "Animation"),
    Genre(title: "Documentary"),
    Genre(title: "Historical"),
    Genre(title: "Musical"),
    Genre(title: "War"),
    Genre(title: "Crime"),
    Genre(title: "Family"),
    Genre(title: "Sports"),
    Genre(title: "Biography")
]
