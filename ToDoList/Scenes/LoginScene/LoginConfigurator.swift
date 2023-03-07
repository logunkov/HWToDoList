//
//  LoginConfigurator.swift
//  ToDoList
//
//  Created by Constantin on 07.03.2023.
//

import UIKit

protocol ILoginConfigurator {
	
	func assemblyMain() -> UIViewController
}

class LoginConfigurator: ILoginConfigurator {
	
	/// Create MainViewController
	/// - Returns: UIViewController
	func assemblyMain() -> UIViewController {
		
		let viewController = MainViewController()
		viewController.modalPresentationStyle = .overFullScreen
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getAllTasks())
		
		let sections = SectionForTaskManagerAdapter(taskManager: taskManager)
		let interactor = MainInteractor(view: viewController, sectionManager: sections)
		viewController.interactor = interactor
		
		return viewController
	}
}
