//
//  MainViewController.swift
//  ToDoList
//
//  Created by Constantin on 12.02.2023.
//

import UIKit

/// IMainViewController
protocol IMainViewController: AnyObject {
	func render(viewData: MainModel.ViewData)
}

/// MainViewController
final class MainViewController: UITableViewController {
	
	var viewData: MainModel.ViewData = MainModel.ViewData(tasksBySections: [])
	var presenter: IMainPresenter?
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		setupView()
		presenter?.viewIsReady()
	}
	
	private func setupView() {
		
		tableView.register(ToDoListCell.self, forCellReuseIdentifier: "cell")
		self.view.backgroundColor = .systemBlue
	}
	
	override func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let tasks = viewData.tasksBySections[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		var contentConfiguration = cell.defaultContentConfiguration()
		
		switch taskData {
		case .importantTask(let task):
			let redText = [NSAttributedString.Key.foregroundColor: UIColor.red]
			let taskText = NSMutableAttributedString(string: "\(task.priority)", attributes: redText)
			taskText.append(NSAttributedString(string: task.name))
			
			contentConfiguration.attributedText = taskText
			contentConfiguration.secondaryText = task.deadLine
			contentConfiguration.secondaryTextProperties.color = task.isOverdue ? .red : .black
			
			if task.isDone {
				contentConfiguration.image = UIImage(systemName: "checkmark.circle")
				contentConfiguration.imageProperties.tintColor = .systemGreen
			} else {
				contentConfiguration.image = UIImage(systemName: "circle")
				contentConfiguration.imageProperties.tintColor = .black
			}
			
		case .regularTask(let task):
			contentConfiguration.text = task.name

			if task.isDone {
				contentConfiguration.image = UIImage(systemName: "checkmark.circle")
				contentConfiguration.imageProperties.tintColor = .systemGreen
			} else {
				contentConfiguration.image = UIImage(systemName: "circle")
				contentConfiguration.imageProperties.tintColor = .black
			}
		}
		
		cell.tintColor = .red
		contentConfiguration.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		contentConfiguration.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
		cell.contentConfiguration = contentConfiguration
		
		return cell
	}
	
	override func tableView(
		_ tableView: UITableView,
		trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
	) -> UISwipeActionsConfiguration? {
		
		let isCompletedAction: UIContextualAction
		let tasks = viewData.tasksBySections[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		
		switch taskData {
			
		case .importantTask(let task):
			isCompletedAction = UIContextualAction(
				style: task.isDone ? .destructive : .normal,
				title: task.isDone ? "undone" : "done") { _, _, complete in
					self.presenter?.didTaskSelected(at: indexPath)
				complete(true)
			}
		case .regularTask(let task):
			isCompletedAction = UIContextualAction(
				style: task.isDone  ? .destructive : .normal,
				title: task.isDone  ? "undone" : "done") { _, _, complete in
					self.presenter?.didTaskSelected(at: indexPath)
				complete(true)
			}
		}

		let configuration = UISwipeActionsConfiguration(actions: [isCompletedAction])
		configuration.performsFirstActionWithFullSwipe = true

		return configuration
	}
}
	
extension MainViewController: IMainViewController {
	
	func render(viewData: MainModel.ViewData) {
		self.viewData = viewData
		tableView.reloadData()
	}
}

// Header & number Of Rows In Section
extension MainViewController {
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		
		viewData.tasksBySections.count
	}
	
	override func tableView(
		_ tableView: UITableView,
		titleForHeaderInSection section: Int
	) -> String? {
		
		viewData.tasksBySections[section].title
	}
	
	override func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		
		let section = viewData.tasksBySections[section]
		return section.tasks.count
	}
	
	override func tableView(
		_ tableView: UITableView,
		willDisplayHeaderView view: UIView, forSection section: Int
	) {

		guard let header = view as? UITableViewHeaderFooterView else { return }
		header.textLabel?.textColor = .white
		header.textLabel?.frame = header.bounds
		header.textLabel?.textAlignment = .center
	}
}
