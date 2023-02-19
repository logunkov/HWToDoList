//
//  Presenter.swift
//  ToDoList
//
//  Created by Constantin on 18.02.2023.
//

import UIKit

/// IView
protocol IView: AnyObject {
	
	func render(viewData: ViewData) 
}

/// Presenter
final class Presenter {
	
	/// view
	weak var view: IView?
	
	/// Create presenter
	/// - Parameter view: IView
	init(view: IView) {
		
		self.view = view
	}
	
	/// Create data cell
	/// - Parameter viewData: ViewData(image, text, secondaryText)
	public	func createDataCell(viewData: ViewData) {
		view?.render(viewData: viewData)
	}
}

/// ViewData
struct ViewData {
	
	/// image
	let image: UIImage?
	
	/// text
	let text: String?
	
	/// secondaryText
	let secondaryText: String?
}
