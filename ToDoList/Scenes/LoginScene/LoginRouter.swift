//
//  LoginRouter.swift
//  ToDoList
//
//  Created by Constantin on 07.03.2023.
//

import UIKit

/// Протокол для LoginRouter.
protocol ILoginRouter {
	
	func routeToTodoList()
	func showError(message: String)
}

final class LoginRouter: ILoginRouter {
	
	private weak var loginViewController: UIViewController!
	private let todoListViewController: UIViewController
	
	internal init(loginViewController: UIViewController!, todoListViewController: UIViewController) {
		self.loginViewController = loginViewController
		self.todoListViewController = todoListViewController
	}

	/// Показать TodoList.
	func routeToTodoList() {
		loginViewController.present(todoListViewController, animated: true)
	}
	
	/// Показать ошибку.
	func showError(message: String) {
		let alert: UIAlertController
		alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
		
		let action = UIAlertAction(title: "Ok", style: .destructive)
		alert.addAction(action)
		loginViewController.present(alert, animated: true, completion: nil)
	}
}
