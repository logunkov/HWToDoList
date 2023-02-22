//
//  Presenter.swift
//  ToDoList
//
//  Created by Constantin on 18.02.2023.
//

import Foundation

/// IMainPresenter.
protocol IMainPresenter {
	
	func viewIsReady()
	func didTaskSelected(at indexPath: IndexPath)
}

/// MainPresenter.
class MainPresenter: IMainPresenter {
	
	private var sectionManager: ISectionForTaskManagerAdapter!
	private weak var view: IMainViewController!
	
	/// Create MainPresenter.
	/// - Parameters:
	///   - view: View
	///   - sectionManager: ISectionForTaskManagerAdapter
	init(view: IMainViewController, sectionManager: ISectionForTaskManagerAdapter!) {
		self.sectionManager = sectionManager
		self.view = view
	}
	
	/// View is ready.
	func viewIsReady() {
		view?.render(viewData: mapViewData())
	}

	/// Did task selected.
	/// - Parameter indexPath: indexPath
	func didTaskSelected(at indexPath: IndexPath) {
		let section = sectionManager.getSection(forIndex: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.isCompleted.toggle()
		view.render(viewData: mapViewData())
	}
	
	private func mapViewData() -> MainModel.ViewData {
		var sections = [MainModel.ViewData.Section]()
		for section in sectionManager.getSections() {
			let sectionData = MainModel.ViewData.Section(
				title: section.title,
				tasks: mapTasksData(tasks: sectionManager.getTasksForSection(section: section) )
			)

			sections.append(sectionData)
		}

		return MainModel.ViewData(tasksBySections: sections)
	}

	private func mapTasksData(tasks: [Task]) -> [MainModel.ViewData.Task] {
		tasks.map{ mapTaskData(task: $0) }
	}

	private func mapTaskData(task: Task) -> MainModel.ViewData.Task {
		if let task = task as? ImportantTask {
			let result = MainModel.ViewData.ImportantTask(
				name: task.name,
				isDone: task.isCompleted,
				isOverdue: task.date < Date(),
				deadLine: "Deadline: \(task.date.formatted())",
				priority: "\(task.priority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(MainModel.ViewData.RegularTask(
				name: task.name,
				isDone: task.isCompleted))
		}
	}
}
