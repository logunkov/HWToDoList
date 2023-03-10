//
//  LoginInteractor.swift
//  ToDoList
//
//  Created by Constantin on 22.02.2023.
//

import Foundation

/// Протокол для LoginInteractor.
protocol ILoginInteractor {
	
	func login(request: LoginModels.Request)
}

/// Интерактор для Login.
final class LoginInteractor: ILoginInteractor {
	
	private var worker: ILoginWorker
	private var presenter: ILoginPresenter?
	
	init(worker: ILoginWorker, presenter: ILoginPresenter) {
		
		self.worker = worker
		self.presenter = presenter
	}
	
	/// Запрос на вход в систему.
	func login(request: LoginModels.Request) {
		
		let result = worker.login(login: request.login, password: request.password)
		let responce = LoginModels.Responce(success: result)
		
		presenter?.present(responce: responce)
	}
	
}
