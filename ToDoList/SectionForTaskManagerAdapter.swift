//
//  SectionForTaskManagerAdapter.swift
//  ToDoList
//
//  Created by Constantin on 18.02.2023.
//

/// Протокол для SectionForTaskManagerAdapter.
protocol ISectionForTaskManagerAdapter {
	func getSections() -> [Section]
	func getTasksForSection(section: Section) -> [Task]
	func taskSectionAndIndex(task: Task) -> (section: Section, index: Int)?
	func getSectionIndex(section: Section) -> Int
	func getSection(forIndex index: Int) -> Section
}

/// Список секций.
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

/// Адаптер для секций списка задач.
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {

	private let sections: [Section] = [.uncompleted, .completed]

	private let taskManager: ITaskManager

	init(taskManager: ITaskManager) {

		self.taskManager = taskManager
	}

	/// Получение списка секций.
	/// - Returns: Массив секций
	func getSections() -> [Section] {
		sections
	}

	/// Получить индекс секции.
	/// - Parameter section: Название секции.
	/// - Returns: Номер секции
	func getSectionIndex(section: Section) -> Int {
		sections.firstIndex(of: section) ?? 0
	}

	/// Получить индекс по секции.
	/// - Parameter index: Номер секции.
	/// - Returns: Секцию.
	func getSection(forIndex index: Int) -> Section {
		let index = min(index, sections.count - 1)
		return sections[index]
	}

	/// Получить задания для секциию
	/// - Parameter section: Секция.
	/// - Returns: Массив заданий.
	func getTasksForSection(section: Section) -> [Task] {
		switch section {
		case .completed:
			return taskManager.completedTasks()
		case .uncompleted:
			return taskManager.uncompletedTasks()
		}
	}

	/// Получить задание и номер для секциию
	/// - Parameter task: Задание.
	/// - Returns: Секция и номер секции.
	func taskSectionAndIndex(task: Task) -> (section: Section, index: Int)? {
		for section in sections {
			let index = getTasksForSection(section: section).firstIndex { task === $0 }
			if index != nil {
				return (section, index!)
			}
		}
		return nil
	}
}
