//
//  ITaskManager.swift
//  ToDoList
//
//  Created by Constantin on 21.02.2023.
//

/// Протокол для TaskManager.
protocol ITaskManager {

	func allTasks() -> [Task]
	func completedTasks() -> [Task]
	func uncompletedTasks() -> [Task]
	func addTask(task: Task)
	func addTasks(tasks: [Task])
}

extension TaskManager: ITaskManager {}

extension ImportantTask.Priority: CustomStringConvertible {

	/// Строковое представление ImportantTask.
	var description: String {

		switch self {

		case .low:
			return "!"
		case .medium:
			return "!!"
		case .high:
			return "!!!"
		}
	}
}
