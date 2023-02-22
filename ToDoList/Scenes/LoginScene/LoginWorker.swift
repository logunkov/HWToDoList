//
//  LoginWorker.swift
//  ToDoList
//
//  Created by Constantin on 22.02.2023.
//

import Foundation

/// LoginDTO.
public struct LoginDTO {
	
	var success: Int
	var login: String
	var lastLoginDate: Date
}

/// ILoginWorker.
protocol ILoginWorker {
	
	func login(login: String, password: String) -> LoginDTO
}

/// LoginWorker
final class LoginWorker: ILoginWorker {
	
	/// Login verification.
	func login(login: String, password: String) -> LoginDTO {
		
		if login == "Admin" && password == "pa$$32!" {
			return LoginDTO(
				success: 1,
				login: login,
				lastLoginDate: Date()
			)
		} else {
			return LoginDTO(
				success: 0,
				login: login,
				lastLoginDate: Date()
			)
		}
	}

}
