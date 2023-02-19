//
//  SectionForTaskManagerAdapter.swift
//  ToDoList
//
//  Created by Constantin on 18.02.2023.
//


/// ISectionForTaskManagerAdapter
protocol ISectionForTaskManagerAdapter {
	
	func getSectionsTitles() -> [String]
	func getTasksForSection(section sectionIndex: Int) -> [Task]
}

/// SectionForTaskManagerAdapter
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	
	private let taskManager: ITaskManager
	
	/// Create section for task manager adapter
	/// - Parameter taskManager: ITaskManager
	init(taskManager: ITaskManager) {
		
		self.taskManager = taskManager
	}
	
	/// Get sections titles
	/// - Returns: [name sections]
	public func getSectionsTitles() -> [String] {
		
		return ["CURRENT TASKS", "COMPLETED TASKS"]
	}
	
	/// Get tasks for section
	/// - Parameter sectionIndex: number of section
	/// - Returns: [Task]
	public func getTasksForSection(section sectionIndex: Int) -> [Task] {
		
		switch sectionIndex {
		case 1:
			return taskManager.completedTasks()
		default:
			return taskManager.uncompletedTasks()
		}
	}
}
