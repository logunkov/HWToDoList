//
//  LoginWorker.swift
//  ToDoList
//
//  Created by Constantin on 22.02.2023.
//

import Foundation

/// Протокол для LoginWorker.
protocol ILoginWorker {
	
	func login(login: String, password: String) -> Bool
}

/// Worker для Login.
final class LoginWorker: ILoginWorker {
	
	private let validLogin = "" // "Admin"
	private let validPassword = "" // "pa$$32!"
	
	/// Проверка входа в систему.
	func login(login: String, password: String) -> Bool {
		login == validLogin && password == validPassword
	}

}
