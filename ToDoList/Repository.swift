//
//  Repository.swift
//  ToDoList
//
//  Created by Constantin on 15.02.2023.
//

/// IRepository
protocol IRepository {
	
	func getAll() -> [Task]
}

/// StubRepository
final class StubRepository: IRepository {
	
	/// Get all tasks
	/// - Returns: tasks
	public func getAll() -> [Task] {
		
		var taskList = [Task]()
		
		for index in 1...9 {
			let isImportantTask = Bool.random()
			
			if isImportantTask {
				taskList.append(ImportantTask(name: "Task №\(index)", priority: ImportantTask.Priority.allCases.randomElement()!))
			} else {
				taskList.append(RegularTask(name: "Task №\(index)"))
			}
		}

		taskList.forEach { task in
			task.isCompleted = Bool.random()
		}
		
		return taskList
	}
}
