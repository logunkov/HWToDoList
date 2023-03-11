//
//  LoginAssembler.swift
//  ToDoList
//
//  Created by Constantin on 10.03.2023.
//

import UIKit

/// Assebler для входа в систему.
final class LoginAssembler {

	/// Сборка.
	func assembly() -> UIViewController {
		let storyBoard = UIStoryboard(name: "LoginScene", bundle: Bundle.main)
		guard let viewController = storyBoard.instantiateViewController(withIdentifier: "LoginScene") as? LoginViewController
		else {fatalError("Not found Maim.storyboard LoginViewController")
		}

		let presenter = LoginPresenter(viewController: viewController)
		let worker = LoginWorker()
		let interactor = LoginInteractor(worker: worker, presenter: presenter)
		viewController.interactor = interactor

		return viewController
	}
}
