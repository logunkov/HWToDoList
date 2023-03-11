//
//  LoginViewController.swift
//  ToDoList
//
//  Created by Constantin on 22.02.2023.
//

import UIKit

/// Протокол для LoginViewController.
protocol ILoginViewController: AnyObject {
	
	func render(viewModel: LoginModels.ViewModel)
}

/// ViewController для Login.
final class LoginViewController: UIViewController {
	
	var interactor: ILoginInteractor?
	var router: ILoginRouter?
	
	@IBOutlet weak var textFieldLogin: UITextField!
	@IBOutlet weak var textFieldPass: UITextField!
	
	@IBAction func buttonLogin(_ sender: Any) {
		
		if let email = textFieldLogin.text, let password = textFieldPass.text {
			let request = LoginModels.Request(login: email, password: password)
			interactor?.login(request: request)
		}
	}
}

extension LoginViewController: ILoginViewController {
	
	/// Отрисовка.
	func render(viewModel: LoginModels.ViewModel) {
		switch viewModel {
		case .success:
			router?.routeToTodoList()
		case .failure(let massenge):
			router?.showError(message: massenge)
		}
	}
}
