//
//  DataModels.swift
//  eduTable
//
//  Created by Jonathan Tam on 2025-09-12.
//

import Foundation
import SwiftUI

struct ClassSchedule: Identifiable {
    
    let id = UUID()
    
    var title: String
    
    var dayOfWeek: Int // 0=Sunday...6=Saturday
    var startHour: Int
    var startMinute: Int
    var durationMinutes: Int
    
    var color: Color
    
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
