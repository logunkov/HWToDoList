//
//  TodoListViewController.swift
//  ToDoList
//
//  Created by Constantin on 12.02.2023.
//

import UIKit

/// Протокол для TodoListViewController.
protocol ITodoListViewController: AnyObject {
	func render(viewModel: TodoListModel.ViewModel)
}

/// ViewController для TodoList.
final class TodoListViewController: UITableViewController {
	
	var viewModel: TodoListModel.ViewModel = TodoListModel.ViewModel(tasksBySections: [])
	var interactor: ITodoListInteractor?
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		setupView()
		interactor?.fetchData() //??
	}
	
	private func setupView() {
		
		tableView.register(ToDoListCell.self, forCellReuseIdentifier: "cell")
		self.view.backgroundColor = .systemBlue
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let tasks = viewModel.tasksBySections[indexPath.section].tasks
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
			
			contentConfiguration = contentConfigurationCell(isDone: task.isDone, contentConfiguration: contentConfiguration)

		case .regularTask(let task):
			contentConfiguration.text = task.name

			contentConfiguration = contentConfigurationCell(isDone: task.isDone, contentConfiguration: contentConfiguration)
		}
		
		cell.tintColor = .red
		contentConfiguration.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		contentConfiguration.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
		cell.contentConfiguration = contentConfiguration
		
		return cell
	}
	
	private func contentConfigurationCell(isDone: Bool, contentConfiguration: UIListContentConfiguration) ->  UIListContentConfiguration {
		
		var contentConfiguration = contentConfiguration
		
		if isDone {
			contentConfiguration.image = UIImage(systemName: "checkmark.circle")
			contentConfiguration.imageProperties.tintColor = .systemGreen
		} else {
			contentConfiguration.image = UIImage(systemName: "circle")
			contentConfiguration.imageProperties.tintColor = .black
		}
		
		return contentConfiguration
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.didTaskSelected(atIndex: TodoListModel.Request.TaskSelected(indexPath: indexPath))
	}
}
	
extension TodoListViewController: ITodoListViewController {
	
	/// Отрисовка.
	func render(viewModel: TodoListModel.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}

extension TodoListViewController {
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		
		viewModel.tasksBySections.count
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		viewModel.tasksBySections[section].title
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		let section = viewModel.tasksBySections[section]
		return section.tasks.count
	}
	
	override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

		guard let header = view as? UITableViewHeaderFooterView else { return }
		header.textLabel?.textColor = .white
		header.textLabel?.frame = header.bounds
		header.textLabel?.textAlignment = .center
	}
}
