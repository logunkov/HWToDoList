//
//  MainModel.swift
//  ToDoList
//
//  Created by Constantin on 21.02.2023.
//


/// MainModel.
enum MainModel {
	
	/// ViewData.
	struct ViewData {
		
		/// RegularTask.
		struct RegularTask {
			
			let name: String
			let isDone: Bool
		}
		
		/// ImportantTask.
		struct ImportantTask {
			
			let name: String
			let isDone: Bool
			let isOverdue: Bool
			let deadLine: String
			let priority: String
		}
		
		/// Task.
		enum Task {
			
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}
		
		/// Section.
		struct Section {
			
			let title: String
			let tasks: [Task]
		}
		
		let tasksBySections: [Section]
	}
}

