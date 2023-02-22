//
//  File.swift
//  ToDoList
//
//  Created by Constantin on 22.02.2023.
//

import Foundation

/// IMainInteractor.
protocol IMainInteractor {
	
	func viewIsReady()
	func didTaskSelected(at indexPath: IndexPath)
}

/// MainPresenter.
final class MainInteractor: IMainInteractor {
	
	private var sectionManager: ISectionForTaskManagerAdapter!
	private weak var view: IMainViewController!
	private var mainPresenter: IMainPresenter!
	
	/// Create MainPresenter.
	/// - Parameters:
	///   - view: View
	///   - sectionManager: ISectionForTaskManagerAdapter
	init(view: IMainViewController, sectionManager: ISectionForTaskManagerAdapter!) {
		self.sectionManager = sectionManager
		self.view = view
		self.mainPresenter = MainPresenter(sectionManager: sectionManager)
	}
	
	/// View is ready.
	func viewIsReady() {
		
		view?.render(viewData: mainPresenter.mapViewData())
	}

	/// Did task selected.
	/// - Parameter indexPath: indexPath
	func didTaskSelected(at indexPath: IndexPath) {
		
		let section = sectionManager.getSection(forIndex: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.isCompleted.toggle()
		view.render(viewData: mainPresenter.mapViewData())
	}
	
}

