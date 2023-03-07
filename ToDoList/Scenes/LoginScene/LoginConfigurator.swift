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
		
		viewController.interactor = MainInteractor(presenter: MainPresenter(viewController: viewController))
		
		return viewController
	}
}
