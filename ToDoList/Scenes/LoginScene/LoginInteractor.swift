//
//  LoginInteractor.swift
//  ToDoList
//
//  Created by Constantin on 22.02.2023.
//

import Foundation

/// ILoginInteractor.
protocol ILoginInteractor {
	
	func login(request: LoginModels.Request)
}

/// LoginInteractor.
final class LoginInteractor: ILoginInteractor {
	
	private var worker: ILoginWorker
	private var presenter: ILoginPresenter?
	
	/// Create LoginInteractorю
	/// - Parameters:
	///   - worker: LoginWorker
	///   - presenter: LoginPresenter
	init(worker: ILoginWorker, presenter: ILoginPresenter) {
		
		self.worker = worker
		self.presenter = presenter
	}
	
	/// Login verificationю
	/// - Parameter request: LoginModels
	func login(request: LoginModels.Request) {
		
		let result = worker.login(login: request.login, password: request.password)
		
		let responce = LoginModels.Responce(
			success: result.success == 1,
			login: result.login,
			lastLoginDate: result.lastLoginDate
		)
		
		presenter?.present(responce: responce)
	}
	
}
