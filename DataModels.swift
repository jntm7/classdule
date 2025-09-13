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
    var color: Color
    
    var dayOfWeek: Int
    var startHour: Int
    var startMinute: Int
    var durationMinutes: Int
}
