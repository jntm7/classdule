//
//  AddClassView.swift
//  Classdule
//
//  Created by Jonathan Tam on 2025-09-13.
//

import SwiftUI

struct AddClassView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var dataManager = ClassDataManager.shared
    
    @State private var className = ""
    @State private var selectedDay = 1 // Default Monday
    @State private var startHour = 9 // Default 9
    @State private var startMinute = 0
    @State private var durationMinutes = 60
    @State private var selectedColor = Color.blue
    
    let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    let colors: [Color] = [.blue, .green, .red, .orange, .purple, .pink, .yellow, .cyan]
    
    var body: some View {
        NavigationView {
            Form {
                classInfoSection
                timeSection
                colorSection
                saveSection
            }
            .navigationTitle("Add Class")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // Class Details
    private var classInfoSection: some View {
        Section("Class Details") {
            TextField("Class Name", text: $className)
            
            Picker("Day Of Week", selection: $selectedDay) {
                ForEach(0..<days.count, id: \.self) {
                    index in Text(days[index]).tag(index)
                }
            }
        }
    }
    
    // Time Details
    private var timeSection: some View {
        Section("Class Time") {
            HStack {
                // Hours
                Text("Start Time")
                Spacer()
                Picker("Hour", selection: $startHour) {
                    ForEach(6..<23) {
                        hour in Text("\(hour)").tag(hour)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80)
                
                // Minutes
                Picker("Minute", selection: $startMinute) {
                    ForEach([0, 15, 30, 45], id: \.self) {
                        minute in Text("\(String(format: "%02d", minute))").tag(minute)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80)
            }
            
            // Duration
            Picker("Duration", selection: $durationMinutes) {
                ForEach([30, 45, 60, 75, 90, 105, 120, 150, 180], id: \.self) {
                    duration in Text("\(duration) min").tag(duration)
                }
            }
        }
    }
    
    // Color Selection
    private var colorSection: some View {
        Section("Color") {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                ForEach(colors, id: \.self) {
                    color in Circle()
                        .fill(color)
                        .frame(width: 40, height: 40)
                        .overlay(Circle().stroke(selectedColor == color ? Color.primary : Color.clear, lineWidth: 3))
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
        }
    }
    
    // Save Class Item
    private var saveSection: some View {
        Section {
            Button("Save Class") {
                saveClass()
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .padding()
            .background(className.isEmpty ? Color.gray : Color.blue)
            .cornerRadius(8)
            .disabled(className.isEmpty)
        }
    }
    
    // Saving the Class
    func saveClass() {
        let newClass = ClassSchedule(
            title: className,
            dayOfWeek: selectedDay,
            startHour: startHour,
            startMinute: startMinute,
            durationMinutes: durationMinutes,
            color: selectedColor
        )
        dataManager.addClass(newClass)
        print("Saved Class: \(className)")
        dismiss()
    }
}

#Preview {
    AddClassView()
}
