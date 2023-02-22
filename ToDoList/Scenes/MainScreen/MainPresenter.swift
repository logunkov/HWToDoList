//
//  Presenter.swift
//  ToDoList
//
//  Created by Constantin on 18.02.2023.
//

import Foundation

/// IMainPresenter.
protocol IMainPresenter {

	func mapViewData() -> MainModel.ViewData
}

/// MainPresenter.
final class MainPresenter: IMainPresenter {
	
	private var sectionManager: ISectionForTaskManagerAdapter!
	
	/// CreateMainPresenter.
	/// - Parameter sectionManager: SectionForTaskManagerAdapter
	init(sectionManager: ISectionForTaskManagerAdapter!) {
		self.sectionManager = sectionManager
	}
	
	/// mapViewData.
	/// - Returns: ViewData
	func mapViewData() -> MainModel.ViewData {
		
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
