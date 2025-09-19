//
//  ClassDataManager.swift
//  Classdule
//
//  Created by Jonathan Tam on 2025-09-13.
//

import Foundation
import SwiftUI

class ClassDataManager: ObservableObject {
    @Published var classes: [ClassSchedule] = []
    
    // Shared Instance
    static let shared = ClassDataManager()
    
    private init() {
        loadSampleData()
    }
    
    // Add Class
    func addClass(_ newClass: ClassSchedule) {
        classes.append(newClass)
        saveClasses()
    }

    // Remove Class
    func removeClass(at index: Int) {
        classes.remove(at: index)
        saveClasses()
    }
    
    // Save to Defaults
    private func saveClasses() {
        if let data = try? JSONEncoder().encode(classes) {
            UserDefaults.standard.set(data, forKey: "savedClasses")
        }
    }
    
    // Load from Defaults
    func loadClasses() {
        if let data = UserDefaults.standard.data(forKey: "savedClasses"),
           let savedClasses = try? JSONDecoder().decode([ClassSchedule].self, from: data) {
            classes = savedClasses
            }
    }
    
    // Load Sample Data
    private func loadSampleData() {
        classes = [
            ClassSchedule(title: "MATH100", dayOfWeek: 1, startHour: 8, startMinute: 30, durationMinutes: 90, color: .blue),
            ClassSchedule(title: "CHEM200", dayOfWeek: 3, startHour: 10, startMinute: 15, durationMinutes: 105, color: .green),
            ClassSchedule(title: "BIO300", dayOfWeek: 5, startHour: 17, startMinute: 0, durationMinutes: 120, color: .yellow)
        ]
    }
}
