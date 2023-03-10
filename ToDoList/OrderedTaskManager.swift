//
//  OrderedTaskManager.swift
//  ToDoList
//
//  Created by Constantin on 18.02.2023.
//

/// Предоставляет список заданий, отсортированных по приоритету.
final class OrderedTaskManager: ITaskManager {
	
	let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		
		self.taskManager = taskManager
	}
	
	/// Список всех заданий.
	/// - Returns: Массив заданий.
	public func allTasks() -> [Task] {
		
		sorted(tasks: taskManager.allTasks())
	}
	
	/// Список выполненных заданий.
	/// - Returns: Массив заданий.
	public func completedTasks() -> [Task] {
		
		sorted(tasks: taskManager.completedTasks())
	}
	
	/// Список заданий для выполнения.
	/// - Returns: Массив заданий.
	public func uncompletedTasks() -> [Task] {
		
		sorted(tasks: taskManager.uncompletedTasks())
	}
	
	/// Добавление перечня заданий.
	/// - Parameter task: Задание.
	public func addTask(task: Task) {
		
		taskManager.addTask(task: task)
	}
	
	/// Добавление перечня заданий.
	/// - Parameter tasks: Массив заданий.
	public func addTasks(tasks: [Task]) {
		
		taskManager.addTasks(tasks: tasks)
	}
	
	private func sorted(tasks: [Task]) -> [Task] {
		
		tasks.sorted {
			
			if $0 is RegularTask, $1 is ImportantTask {
				return false
			}
			
			if let task0 = $0 as? ImportantTask, let task1 = $1 as? ImportantTask {
				return task0.taskPriority.rawValue > task1.taskPriority.rawValue
			}
		
			return true
		}
	}
}
