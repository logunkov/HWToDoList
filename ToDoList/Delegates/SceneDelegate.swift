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
		window.rootViewController = assemblyLogin()
		window.makeKeyAndVisible()
		self.window = window
	}
	
	private func assemblyLogin() -> UIViewController {
		
		let storyboard = UIStoryboard(name: "LoginScene", bundle: Bundle.main)
		guard let viewController = storyboard.instantiateViewController(withIdentifier: "LoginScene") as? LoginViewController
		else {
			fatalError("Not found Maim.storyboard LoginViewController")
		}

		return viewController
	}
}
