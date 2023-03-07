//
//  LoginRouter.swift
//  ToDoList
//
//  Created by Constantin on 07.03.2023.
//

import UIKit

protocol ILoginRouter {
	
	func showMain (from viewController: UIViewController)
}

class LoginRouter: ILoginRouter {
	
	static let shared = LoginRouter ()
	private let configurator: ILoginConfigurator = LoginConfigurator()
	
	private init() {}
	
	func showMain (from viewController: UIViewController) {
		
		let vc = configurator.assemblyMain()
		viewController.present(vc, animated: true)
	}
}
