//
//  LoginModels.swift
//  ToDoList
//
//  Created by Constantin on 22.02.2023.
//

import Foundation

/// Вход в систему.
enum LoginModels {
	
	/// Запрос логина и пароля.
	struct Request {
		
		var login: String
		var password: String
	}
	
	/// Ответ о успешной авторизации.
	struct Responce {
		
		var success: Bool
	}
	
	/// Данные для входа в систему.
	enum ViewModel {
		
		case success
		case failure(String)
	}
}
