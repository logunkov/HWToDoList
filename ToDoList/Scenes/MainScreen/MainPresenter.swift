//
//  Presenter.swift
//  ToDoList
//
//  Created by Constantin on 18.02.2023.
//

import Foundation

/// IMainPresenter.
protocol IMainPresenter {

	func present(responce: MainModel.ViewData)
}

/// MainPresenter.
final class MainPresenter: IMainPresenter {
	
	private weak var viewController: IMainViewController?
	
	/// CreateMainPresenter.
	/// - Parameter sectionManager: SectionForTaskManagerAdapter
	init(viewController: IMainViewController?) {
		
		self.viewController = viewController
	}
	
	func present(responce: MainModel.ViewData) {
		
		viewController?.render(viewData: responce)
	}
}
