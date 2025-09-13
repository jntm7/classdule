//
//  ClassItemView.swift
//  eduTable
//
//  Created by Jonathan Tam on 2025-09-13.
//

import SwiftUI

struct ClassItemView: View {
    let classItem: ClassSchedule
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(classItem.title)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .lineLimit(2)
            
            Text(classItem.timeDisplay)
                .font(.caption2)
                .foregroundColor(.white.opacity(0.9))
        }
        .padding(6)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(classItem.color)
        .cornerRadius(6)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    ClassItemView(classItem: ClassSchedule(
        title: "Math 101",
        dayOfWeek: 1,
        startHour: 8,
        startMinute: 30,
        durationMinutes: 90,
        color: .blue
    ))
    .frame(width: 100)
    .padding()
}
