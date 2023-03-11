//
//  TodoListModel.swift
//  ToDoList
//
//  Created by Constantin on 21.02.2023.
//

import Foundation

/// Задания из списка.
enum TodoListModel {

	/// Запрос на обновление после выбора задания из списка.
	enum Request {
		struct TaskSelected {
			/// Индекс задания, выбанного в списке
			let indexPath: IndexPath
		}
	}

	/// Ответ на обновление после выбора задания из списка.
	struct Response {
		struct SectionWithTasks {
			let section: Section
			let tasks: [Task]
		}
		let data: [SectionWithTasks]
	}

	/// Данные для заданий из списка.
	struct ViewModel {
		struct RegularTask {
			let name: String
			let isDone: Bool
		}

		struct ImportantTask {
			let name: String
			let isDone: Bool
			let isOverdue: Bool
			let deadLine: String
			let priority: String
		}

		enum Task {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}

		struct Section {
			let title: String
			let tasks: [Task]
		}

		let tasksBySections: [Section]
	}
}
