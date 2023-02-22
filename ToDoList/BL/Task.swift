//
//  Task.swift
//  ToDoList
//
//  Created by Constantin on 12.02.2023.
//

import Foundation

/// Create task.
class Task {
	
	/// Name task.
	let name: String
	
	/// Task is completed.
	var isCompleted: Bool
	
	/// Create class task.
	/// - Parameter name: name task.
	init (name: String, isCompleted: Bool = false) {
		self.name = name
		self.isCompleted = isCompleted
	}
}

/// Create regular task.
final class RegularTask: Task  {}

/// Create important Task.
final class ImportantTask: Task {
	
	/// Enum priority task.
	enum Priority: Int, CaseIterable {
		
		case low
		case medium
		case high
	}
	
	/// Priority task.
	var priority: Priority
	
	/// Date task.
	var date: Date {
		switch priority {
		case .low:
			return Calendar.current.date(byAdding: .day, value: 3, to: Date())!
		case .medium:
			return Calendar.current.date(byAdding: .day, value: 2, to: Date())!
		case .high:
			return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
		}
	}
	
	/// Create class importantTask.
	/// - Parameters:
	///   - name: name ImportantTask.
	///   - priority: priority ImportantTask.
	init(name: String, priority: Priority) {
		self.priority = priority
		super.init(name: name)
	}
}
