//
//  OrderedTaskManager.swift
//  ToDoList
//
//  Created by Constantin on 18.02.2023.
//


/// OrderedTaskManager
final class OrderedTaskManager: ITaskManager {
	
	private let taskManager: ITaskManager
	
	/// Create OrderedTaskManager
	/// - Parameter taskManager: ITaskManager
	init(taskManager: ITaskManager) {
		
		self.taskManager = taskManager
	}
	
	/// Get all tasks
	/// - Returns: [Task]
	public func allTasks() -> [Task] {
		
		sorted(tasks: taskManager.allTasks())
	}
	
	/// Get all copleted tasks
	/// - Returns: [Task]
	public func completedTasks() -> [Task] {
		
		sorted(tasks: taskManager.completedTasks())
	}
	
	/// Get all uncopleted tasks
	/// - Returns: [Task]
	public func uncompletedTasks() -> [Task] {
		
		sorted(tasks: taskManager.uncompletedTasks())
	}
	
	/// Add task
	/// - Parameter tasks: [Task]
	public func addTasks(tasks: [Task]) {
		
		taskManager.addTasks(tasks: tasks)
	}
	
	private func sorted(tasks: [Task]) -> [Task] {
		
		tasks.sorted {
			
			if $0 is RegularTask, $1 is ImportantTask {
				return false
			}
			
			if let task0 = $0 as? ImportantTask, let task1 = $1 as? ImportantTask {
				return task0.priority.rawValue > task1.priority.rawValue
			}
		
			return true
		}
	}
}
