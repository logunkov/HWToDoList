//
//  LoginPresenter.swift
//  ToDoList
//
//  Created by Constantin on 22.02.2023.
//

/// Протокол для LoginPresenter.
protocol ILoginPresenter {
	
	func present(responce: LoginModels.Responce)
}

/// Presenter для Login.
final class LoginPresenter: ILoginPresenter {
	
	private weak var viewController: ILoginViewController?
	
	init(viewController: ILoginViewController?) {
		
		self.viewController = viewController
	}
	
	/// Ответ входа в систему.
	/// - Parameter responce: Данные входа в систему.
	func present(responce: LoginModels.Responce) {
		
		let viewModel: LoginModels.ViewModel = responce.success ? .success: .failure("Access denied")
		
		viewController?.render(viewModel: viewModel)
	}
}
