//
//  TodoListAssembler.swift
//  ToDoList
//
//  Created by Constantin on 10.03.2023.
//

import UIKit

/// Assebler для TodoList.
final class TodoListAssembler {

	/// Сборка.
	func assembly() -> UIViewController {

		let viewController = TodoListViewController()
		viewController.modalPresentationStyle = .overFullScreen

		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getTasks())

		let sectionForTaskManagerAdapter = SectionForTaskManagerAdapter(taskManager: taskManager)
		let presenter = TodoListPresenter(viewController: viewController)
		let interactor = TodoListInteractor(sectionManager: sectionForTaskManagerAdapter, presenter: presenter)

		viewController.interactor = interactor
		return viewController
	}
}
