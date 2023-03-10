//
//  LoginModels.swift
//  ToDoList
//
//  Created by Constantin on 22.02.2023.
//

import Foundation

/// Модель входа в систему.
enum LoginModels {
	
	/// Запрос.
	struct Request {
		
		var login: String
		var password: String
	}
	
	/// Ответ.
	struct Responce {
		
		var success: Bool
	}
	
	/// Данные для входа в систему.
	enum ViewModel {
		
		case success
		case failure(String)
	}
}
