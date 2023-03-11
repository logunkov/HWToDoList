//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by Constantin on 12.02.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
			   options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let winScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: winScene)
		window.rootViewController = assembly()
		window.makeKeyAndVisible()
		self.window = window
	}
	
	func assembly() -> UIViewController {
		let loginViewController = LoginAssembler().assembly()
		let todoListViewController = TodoListAssembler().assembly()
		
		let router = LoginRouter(
			loginViewController: loginViewController,
			todoListViewController: todoListViewController
		)

		if let loginViewController = loginViewController as? LoginViewController {
			loginViewController.router = router
		}
		
		return loginViewController
	}
}
