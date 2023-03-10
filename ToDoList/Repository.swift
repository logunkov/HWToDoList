//
//  Repository.swift
//  ToDoList
//
//  Created by Constantin on 15.02.2023.
//

/// Протокол для TaskRepositoryStub.
protocol ITaskRepository {
	
	func getTasks() -> [Task]
}

/// Заглушка репозиторий.
final class TaskRepositoryStub: ITaskRepository {
	
	/// Создаем список всех заданий.
	/// - Returns: Массив заданий.
	public func getTasks() -> [Task] {
		
		var taskList = [Task]()
		
		for index in 1...9 {
			let isImportantTask = Bool.random()
			
			if isImportantTask {
				taskList.append(
					ImportantTask(name: "Task №\(index)",
								  priority: ImportantTask.Priority.allCases.randomElement()!))
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
