//
//  ContentView.swift
//  eduTable
//
//  Created by Jonathan Tam on 2025-09-12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TimetableView()
                .navigationTitle("My Schedule")
        }
    }
}

#Preview {
    ContentView()
}
