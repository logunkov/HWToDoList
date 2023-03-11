//
//  TodoListInteractor.swift
//  ToDoList
//
//  Created by Constantin on 22.02.2023.
//

import Foundation

/// Протокол для TodoListInteractor.
protocol ITodoListInteractor {

	func fetchData()
	func didTaskSelected(atIndex: TodoListModel.Request.TaskSelected)
}

/// Interactor для TodoList.
final class TodoListInteractor: ITodoListInteractor {

	private var sectionManager: ISectionForTaskManagerAdapter
	private var presenter: ITodoListPresenter

	internal init(sectionManager: ISectionForTaskManagerAdapter, presenter: ITodoListPresenter) {
		self.sectionManager = sectionManager
		self.presenter = presenter
	}

	/// Извлечь данные.
	func fetchData() {
		var responseData = [TodoListModel.Response.SectionWithTasks]()
		for section in sectionManager.getSections() {
			let sectionWithTasks = TodoListModel.Response.SectionWithTasks(
				section: section,
				tasks: sectionManager.getTasksForSection(section: section)
			)
			responseData.append(sectionWithTasks)
		}
		let response = TodoListModel.Response(data: responseData)
		presenter.present(responce: response)
	}

	/// Выбранное задание.
	func didTaskSelected(atIndex index: TodoListModel.Request.TaskSelected) {
		let section = sectionManager.getSection(forIndex: index.indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[index.indexPath.row]
		task.isCompleted.toggle()
		fetchData()
	}
}
