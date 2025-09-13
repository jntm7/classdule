//
//  HomeView.swift
//  eduTable
//
//  Created by Jonathan Tam on 2025-09-13.
//

import SwiftUI

struct HomeView: View {
    // Dark Mode
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                VStack(spacing: 20) {
                    Image(systemName: "calendar")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    
                    Text("EDUschedule")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding(.top, 50)
                Spacer()
                
                VStack(spacing: 30) {
                    
                    // Add Class
                    NavigationLink(destination: AddClassView()) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                            Text("Add a Class")
                                .font(.title2)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 30)
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    
                    // Timetable
                    NavigationLink(destination: TimetableView()) {
                        HStack {
                            Image(systemName: "calendar.day.timeline.left")
                                .font(.title2)
                            Text("View Schedule")
                                .font(.title2)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 30)
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    
                    // Dark Mode Toggle
                    HStack {
                        Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                            .font(.title2)
                        Text(isDarkMode ? "Dark Mode" : "Light Mode")
                            .font(.title2)
                            .fontWeight(.medium)
                        Spacer()
                        Toggle("", isOn: $isDarkMode)
                            .labelsHidden()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 30)
                    .background(Color.blue.opacity(0.5))
                    .cornerRadius(10)
                    
                }
                .padding(.horizontal, 25)
                Spacer()
            }
            .navigationBarHidden(true)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
    
}

#Preview {
    HomeView()
}
