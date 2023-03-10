//
//  Task.swift
//  ToDoList
//
//  Created by Constantin on 12.02.2023.
//

import Foundation

/// Задание, для ведения списка дел.
class Task {
	
	/// Наименование задания.
	let name: String
	
	/// Состояние задания -- выполнено ли задание.
	var isCompleted: Bool
	
	init (name: String, isCompleted: Bool = false) {
		self.name = name
		self.isCompleted = isCompleted
	}
}

/// Обычное задание.
final class RegularTask: Task  {}

/// Важное задание с приоритетом.
final class ImportantTask: Task {
	
	/// Приоритет задания. Приоритет влияет на крайний срок выполнения задания.
	enum Priority: Int, CaseIterable {
		/// Низкий приоритет. На выполнение задания с низким приоритетом, отводится 3 дня.
		case low
		/// Средний приоритет. На выполнение задания со средним приоритетом, отводится 2 дня.
		case medium
		/// Высокий приоритет. На выполнение задания с высоким приоритетом, отводится 1 день.
		case high
	}
	
	private let createDate: Date
	
	/// Приоритет задания.
	var taskPriority: Priority
	
	/// Крайний срок выполнения задания.
	var deadLine: Date {
		switch taskPriority {
		case .low:
			return Calendar.current.date(byAdding: .day, value: 3, to: Date())!
		case .medium:
			return Calendar.current.date(byAdding: .day, value: 2, to: Date())!
		case .high:
			return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
		}
	}
	
	init(name: String, priority: Priority, createDate: Date = Date()) {
		self.taskPriority = priority
		self.createDate = createDate
		super.init(name: name)
	}
}
