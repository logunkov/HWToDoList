//
//  File.swift
//  ToDoList
//
//  Created by Constantin on 22.02.2023.
//

import Foundation

/// IMainInteractor.
protocol IMainInteractor {
	
	func viewIsReady()
	func didTaskSelected(at indexPath: IndexPath)
	func mapViewData() -> MainModel.ViewData
}

/// MainPresenter.
final class MainInteractor: IMainInteractor {
	
	private var sectionManager: ISectionForTaskManagerAdapter!
	private var presenter: IMainPresenter!
	
	/// Create MainPresenter.
	/// - Parameters:
	///   - view: View
	///   - sectionManager: ISectionForTaskManagerAdapter
	init(presenter: IMainPresenter!) {
		self.presenter = presenter
		self.sectionManager = getSectionManager()
	}
	
	/// View is ready.
	func viewIsReady() {
		
		let responce =  mapViewData()
		presenter.present(responce: responce)
	}

	/// Did task selected.
	/// - Parameter indexPath: indexPath
	func didTaskSelected(at indexPath: IndexPath) {
		
		let section = sectionManager.getSection(forIndex: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.isCompleted.toggle()
		
		let responce = mapViewData()
		presenter.present(responce: responce)

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
				isOverdue: task.deadLine < Date(),
				deadLine: "Deadline: \(task.deadLine.formatted())",
				priority: "\(task.taskPriority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(MainModel.ViewData.RegularTask(
				name: task.name,
				isDone: task.isCompleted))
		}
	}
	
	private func getSectionManager() -> ISectionForTaskManagerAdapter {
		
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getTasks())
		let sections = SectionForTaskManagerAdapter(taskManager: taskManager)
		
		return sections
	}
}

