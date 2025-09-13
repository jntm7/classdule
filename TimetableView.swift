//
//  TimetableView.swift
//  eduTable
//
//  Created by Jonathan Tam on 2025-09-13.
//

import SwiftUI

struct TimetableView: View {
    @ObservedObject var dataManager = ClassDataManager.shared
        
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let hours = Array(6...22) // 6AM to 10PM
    
    var body: some View {
        ScrollView {
            VStack(spacing: 1) {
                headerRow
                
                ForEach(hours, id: \.self) {
                    hour in
                        timeRow(for: hour)
                }
            }
            .padding()
        }
        .navigationTitle("My Schedule")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Header Row
    private var headerRow: some View {
        HStack(spacing: 1) {
            Text("")
                .frame(width: 60, height: 40)
            
            // Days
            ForEach(days, id: \.self) {
                day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        //.padding(.vertical, 10)
                        //.padding(.horizontal, 5)
                        .background(Color.gray.opacity(0.1))
            }
        }
    }
    
    // Time Row
    private func timeRow(for hour: Int) -> some View {
        HStack(spacing: 1) {
            Text(formatHour(hour))
                .font(.caption2)
                .frame(width: 60, height: 40)
                .background(Color.gray.opacity(0.05))
            
            ForEach(0..<7) {
                dayIndex in
                   dayCell(day: dayIndex, hour: hour)
            }
        }
    }
    
    // Day Cell
    private func dayCell(day: Int, hour: Int) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .frame(minHeight: 60)
                .border(Color.gray.opacity(0.3), width: 0.5)
            
            if let classItem = getClassForSlot(day: day, hour: hour) {
                classBlock(for: classItem)
            }
        }
        .frame(maxWidth: .infinity)
    }
    

    // Class Block
    private func classBlock(for classItem: ClassSchedule) -> some View {
        VStack(spacing: 2) {
            Text(classItem.title)
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .padding(5)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(classItem.color)
        .cornerRadius(4)
        .padding(1)
    }
    
    // Get Class Item
    func getClassForSlot(day: Int, hour: Int) -> ClassSchedule? {
        return dataManager.classes.first {
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
