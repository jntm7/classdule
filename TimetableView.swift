//
//  TimetableView.swift
//  eduTable
//
//  Created by Jonathan Tam on 2025-09-13.
//

import SwiftUI

struct TimetableView: View {
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let hours = Array(6...22) // 6AM to 10PM
    
    // Test Data
    let classes: [ClassSchedule] = [
        ClassSchedule(title: "MATH100", dayOfWeek: 1, startHour: 8, startMinute: 30, durationMinutes: 90, color: .blue),
        ClassSchedule(title: "CHEM200", dayOfWeek: 3, startHour: 10, startMinute: 15, durationMinutes: 105, color: .green),
        ClassSchedule(title: "BIO300", dayOfWeek: 5, startHour: 17, startMinute: 0, durationMinutes: 120, color: .yellow)
    ]
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 1) {
                
                // Header Row
                Text("")
                    .frame(width: 60, height: 40)
                
                // X-Axis Columns (Days)
                ForEach(days, id: \.self) {
                    day in Text(day)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        //.padding(.horizontal, 5)
                        .background(Color.gray.opacity(0.1))
                }
                
                // Y-Axis (Time)
                ForEach(hours, id: \.self) {
                    hour in
                        // Time Columns
                        Text("\(formatHour(hour))")
                            .font(.caption2)
                            .frame(width: 60, height: 60)
                            .background(Color.gray.opacity(0.1))
                        
                        // Day Columns
                        ForEach(0..<7) {
                            dayIndex in ZStack {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(minHeight: 60)
                                    .border(Color.gray.opacity(0.2), width: 0.5)
                                
                                if let classForSlot = getClassForSlot(day: dayIndex, hour: hour) {
                                    VStack(spacing: 2) {
                                        Text(classForSlot.title)
                                            .font(.caption2)
                                            .fontWeight(.medium)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                        Text(classForSlot.timeDisplay)
                                            .font(.system(size: 8))
                                            .foregroundColor(.white.opacity(0.9))
                                    }
                                    .padding(4)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(classForSlot.color)
                                    .cornerRadius(6)
                                    .padding(1)
                                }
                            }
                        }
                    }
                }
                .padding()
        }
        .navigationTitle("My Schedule")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Grid Layout
    var gridColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 1), count: 8)
    }
    
    // Get Class Item
    func getClassForSlot(day: Int, hour: Int) -> ClassSchedule?{
        return classes.first {
            classItem in
                classItem.dayOfWeek == day &&
                classItem.startHour <= hour &&
                hour < classItem.startHour + (classItem.durationMinutes / 60)
        }
    }

    // Format Hour for Display
    func formatHour(_ hour: Int) -> String {
        if hour == 0 {
            return "12:00AM"
        } else if hour < 12 {
            return "\(hour):00AM"
        } else if hour == 12 {
            return "12:00PM"
        } else {
            return "\(hour - 12):00PM"
        }
    }
}

#Preview {
    NavigationView {
        TimetableView()
    }
}
