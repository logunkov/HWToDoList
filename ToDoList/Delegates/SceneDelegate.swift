//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by Constantin on 12.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
			   options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let winScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: winScene)
		window.rootViewController = assembly()
		window.makeKeyAndVisible()
		self.window = window
	}
	
	private func assembly() -> UIViewController {
		
		let viewController = MainViewController()
		
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getAll())
		let sections = SectionForTaskManagerAdapter(taskManager: taskManager)
		
		let presenter = MainPresenter(view: viewController, sectionManager: sections)
		viewController.presenter = presenter
		
		return viewController
	}
}
