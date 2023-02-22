//
//  ITaskManager.swift
//  ToDoList
//
//  Created by Constantin on 21.02.2023.
//

/// ITaskManager.
protocol ITaskManager {
	
	func allTasks() -> [Task]
	func completedTasks() -> [Task]
	func uncompletedTasks() -> [Task]
	func addTasks(tasks: [Task])
}

extension TaskManager: ITaskManager { }

extension ImportantTask.Priority: CustomStringConvertible {
	
	/// Description important task.
	var description: String {
		
		switch self {
			
		case .low:
			return "!"
		case .medium:
			return "!!"
		case .high :
			return "!!!"
		}
	}
}
