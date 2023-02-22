//
//  LoginPresenter.swift
//  ToDoList
//
//  Created by Constantin on 22.02.2023.
//

/// ILoginPresenter.
protocol ILoginPresenter {
	
	func present(responce: LoginModels.Responce)
}

/// LoginPresenter.
final class LoginPresenter: ILoginPresenter {
	
	private weak var viewController: ILoginViewController?
	
	/// Create LoginPresenter.
	/// - Parameter viewController: LoginViewController
	init(viewController: ILoginViewController?) {
		
		self.viewController = viewController
	}
	
	/// Responce LoginModels.
	/// - Parameter responce: LoginModels.Responce
	func present(responce: LoginModels.Responce) {
		
		let viewModel = LoginModels.ViewModel(
			success: responce.success,
			userName: responce.login,
			lastLoginDate: "\(responce.lastLoginDate)"
		)
		
		viewController?.render(viewModel: viewModel)
	}
}
