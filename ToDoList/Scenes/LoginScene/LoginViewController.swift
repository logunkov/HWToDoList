//
//  LoginViewController.swift
//  ToDoList
//
//  Created by Constantin on 22.02.2023.
//

import UIKit

/// ILoginViewController.
protocol ILoginViewController: AnyObject {
	
	func render(viewModel: LoginModels.ViewModel)
}

/// LoginViewController.
final class LoginViewController: UIViewController {
	
	private var interactor: ILoginInteractor?
	
	@IBOutlet weak var textFieldLogin: UITextField!
	@IBOutlet weak var textFieldPass: UITextField!
	
	@IBAction func buttonLogin(_ sender: Any) {
		
		if let email = textFieldLogin.text, let password = textFieldPass.text {
			let request = LoginModels.Request(login: email, password: password)
			interactor?.login(request: request)
		}
	}
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		assembly()
	}
	
	/// Create interactor.
	func assembly() {
		
		let worker = LoginWorker()
		let presenter = LoginPresenter(viewController: self)
		interactor = LoginInteractor(worker: worker, presenter: presenter)
	}

}

extension LoginViewController: ILoginViewController {
	
	/// Create render.
	func render(viewModel: LoginModels.ViewModel) {
				
		let alert: UIAlertController
		
		if viewModel.success {
			alert = UIAlertController(
				title: "Access successful",
				message: viewModel.userName,
				preferredStyle: UIAlertController.Style.alert
			)
		} else {
			alert = UIAlertController(
				title: "Access denied",
				message: "Invalid username or password",
				preferredStyle: UIAlertController.Style.alert
			)
		}
		
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
			if viewModel.success {
				let mainViewController = self.assemblyMain()
				self.navigationController?.pushViewController(mainViewController, animated: true)
			}
		}))
		present(alert, animated: true, completion: nil)
	}
	
	private func assemblyMain() -> UIViewController {
		
		let viewController = MainViewController()
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getAll())
	
		let sections = SectionForTaskManagerAdapter(taskManager: taskManager)
		let interactor = MainInteractor(view: viewController, sectionManager: sections)
		viewController.interactor = interactor
		
		return viewController
	}

}
