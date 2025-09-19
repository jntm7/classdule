//
//  DataModels.swift
//  Classdule
//
//  Created by Jonathan Tam on 2025-09-12.
//

import Foundation
import SwiftUI

struct ClassSchedule: Identifiable, Codable {
    
    var id = UUID()
    var title: String
    var dayOfWeek: Int
    var startHour: Int
    var startMinute: Int
    var durationMinutes: Int
    
    // Color
    var colorName: String
    var color: Color {
        switch colorName {
            case "blue": return .blue
            case "green": return .green
            case "yellow": return .yellow
            case "orange": return .orange
            case "red": return .red
            case "purple": return .purple
            default: return .blue
        }
    }
    
    // Initializer
    init(title: String, dayOfWeek: Int, startHour: Int, startMinute: Int, durationMinutes: Int, color: Color) {
        self.title = title
        self.dayOfWeek = dayOfWeek
        self.startHour = startHour
        self.startMinute = startMinute
        self.durationMinutes = durationMinutes
            
        switch color {
        case .green:
            self.colorName = "green"
        case .yellow: 
            self.colorName = "yellow"
        case .orange: 
            self.colorName = "orange"
        case .red:
            self.colorName = "red"
        case .purple:
            self.colorName = "purple"
        default: 
            self.colorName = "blue"
        }
    }

    // Display Time
    var timeDisplay: String {
        let startTime = formatTime(hour: startHour, minute: startMinute)
        let endTime = calculateEndTime()
        
        return "\(startTime) - \(endTime)"
    }
    
    // Calculate Total Minutes
    var minutesFromStartOfDay: Int {
        return (startHour - 6) * 60 + startMinute
    }
    
    // Calculate Duration
    private func calculateEndTime() -> String {
        let totalStartMinutes = startHour * 60 + startMinute
        let totalEndMinutes = totalStartMinutes + durationMinutes
        let endHour = totalEndMinutes / 60
        let endMinute = totalEndMinutes % 60
        
        return formatTime(hour: endHour, minute: endMinute)
    }
    
    // Format Time for Display
    private func formatTime(hour: Int, minute: Int) -> String {
        let displayHour: Int
        let timeOfDay: String
        
        // Handle AM/PM
        if hour == 0 {
            displayHour = 12
            timeOfDay = "AM"
        } else if hour < 12 {
            displayHour = hour
            timeOfDay = "AM"
        } else if hour == 12 {
            displayHour = 12
            timeOfDay = "PM"
        } else {
            displayHour = hour - 12
            timeOfDay = "PM"
        }
        
        // Display
        if minute == 0 {
            return "\(displayHour) \(timeOfDay)"
        } else {
            return "\(displayHour):\(String(format: "%02d", minute))\(timeOfDay)"
        }
        
    }
    
}
