//
//  SectionForTaskManagerAdapter.swift
//  ToDoList
//
//  Created by Constantin on 18.02.2023.
//

/// ISectionForTaskManagerAdapter.
protocol ISectionForTaskManagerAdapter {
	func getSections() -> [Section]
	func getTasksForSection(section: Section) -> [Task]
	func taskSectionAndIndex(task: Task) -> (section: Section, index: Int)?
	func getSectionIndex(section: Section) -> Int
	func getSection(forIndex index: Int) -> Section
}

/// enum Section.
enum Section: CaseIterable {
	case completed
	case uncompleted
	
	var title: String {
		switch self {
		case .completed:
			return "COMPLETED TASKS"
		case .uncompleted:
			return "CURRENT TASKS"
		}
	}
}

/// Creation SectionForTaskManagerAdapter.
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	
	private let sections: [Section] = [.uncompleted, .completed]
	
	private let taskManager: ITaskManager
	
	/// Create section for task manager adapter.
	/// - Parameter taskManager: ITaskManager.
	init(taskManager: ITaskManager) {
		
		self.taskManager = taskManager
	}
	
	/// Get sections array.
	/// - Returns: [name sections]
	func getSections() -> [Section] {
		sections
	}
	
	/// Get sections index.
	/// - Parameter section: name section.
	/// - Returns: number
	func getSectionIndex(section: Section) -> Int {
		sections.firstIndex(of: section) ?? 0
	}
	
	/// Get sections by index.
	/// - Parameter index: number of index.
	/// - Returns: name section.
	func getSection(forIndex index: Int) -> Section {
		let i = min(index, sections.count - 1)
		return sections[i]
	}
	
	/// Get tasks for section.
	/// - Parameter section: name section.
	/// - Returns: [Task]
	func getTasksForSection(section: Section) -> [Task] {
		switch section {
		case .completed:
			return taskManager.completedTasks()
		case .uncompleted:
			return taskManager.uncompletedTasks()
		}
	}
	
	/// Get sections and index.
	/// - Parameter task: task.
	/// - Returns: name and number.
	func taskSectionAndIndex(task: Task) -> (section: Section, index: Int)? {
		for section in sections {
			let index = getTasksForSection(section: section).firstIndex{ task === $0 }
			if index != nil {
				return (section, index!)
			}
		}
		return nil
	}
}
