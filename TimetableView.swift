//
//  TimetableView.swift
//  eduTable
//
//  Created by Jonathan Tam on 2025-09-13.
//

import SwiftUI

struct TimetableView: View {
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let hours = Array(6...22)
    
    // Test Data
    @State private var classes: [ClassSchedule] = [
        ClassSchedule(title: "MATH100", dayOfWeek: "Mon", startHour: 8, startMinute: 30, durationMinutes: 90, color: .blue)
        ClassSchedule(title: "MATH100", dayOfWeek: "Wed", startHour: 10, startMinute: 15, durationMinutes: 105, color: .green)
        ClassSchedule(title: "MATH100", dayOfWeek: "Fri", startHour: 17, startMinute: 0, durationMinutes: 120, color: .yellow)
    ]
    
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // X-Axis (Days)
                HStack(spacing: 0) {
                    
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 60)
                    
                    // X-Axis Columns (Days)
                    ForEach(days, id: \.self) {
                        day in Text(day)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 5)
                            .background(Color.gray.opacity(0.1))
                    }
                    
                }
                
                // Y-Axis (Time)
                ForEach(hours, id: \.self) {
                    hour in HStack(spacing: 0) {
                        
                        // Time Columns
                        Text("\(formatHour(hour))")
                            .font(.caption)
                            .frame(width: 60)
                            .padding(.vertical, 20)
                        
                        // Day Columns
                        ForEach(0..<7) {
                            dayIndex in Rectangle()
                                .fill(Color.clear)
                                .frame(maxWidth: .infinity, minHeight: 60)
                                .border(Color.gray.opacity(0.2), width: 0.5)
                        }
                    }
                }
                
            }
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
    TimetableView()
}
