//
//  LoginModels.swift
//  ToDoList
//
//  Created by Constantin on 22.02.2023.
//

import Foundation

/// LoginModels.
enum LoginModels {
	
	/// Request
	struct Request {
		
		var login: String
		var password: String
	}
	
	/// Responce.
	struct Responce {
		
		var success: Bool
		var login: String
		var lastLoginDate: Date
	}
	
	/// ViewModel.
	struct ViewModel {
		
		var success: Bool
		var userName: String
		var lastLoginDate: String
	}
}
