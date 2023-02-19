//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by Constantin on 12.02.2023.
//

import UIKit

/// TaskListViewController
final class TaskListViewController: UITableViewController {
	
	private var contentConfiguration = UITableViewCell().defaultContentConfiguration()
	private var sectionForTaskManager: ISectionForTaskManagerAdapter!
	private lazy var presenter = Presenter(view: self)

	override func viewDidLoad() {
		
		super.viewDidLoad()
		setup()
		setupView()
	}
	
	private func setupView() {
		
		tableView.register(ToDoListCell.self, forCellReuseIdentifier: "cell")
		self.view.backgroundColor = .systemBlue
	}
	
	private func setup() {
		
		let taskManager: ITaskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: IRepository = StubRepository()
		
		taskManager.addTasks(tasks: repository.getAll())
		sectionForTaskManager = SectionForTaskManagerAdapter(taskManager: taskManager)
	}
	
	private func getTaskForIndex(_ indexPath: IndexPath) -> Task {
		
		sectionForTaskManager.getTasksForSection(section: indexPath.section)[indexPath.row]
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewWillAppear(animated)
		tableView.reloadData()
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let currentTask = getTaskForIndex(indexPath)
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		if let currentTask = currentTask as? ImportantTask, currentTask.date < Date() && !currentTask.isCompleted  {
			cell.backgroundColor = .systemPink
		}
		
		let viewData = createCell(currentTask: currentTask)
		presenter.createDataCell(viewData: viewData)
		
		cell.contentConfiguration = contentConfiguration
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let currentTask = getTaskForIndex(indexPath)
		
		let isCompletedAction = UIContextualAction(style: currentTask.isCompleted ? .destructive : .normal,
												   title: currentTask.isCompleted ? "undone" : "done") { _, _, complete in
			currentTask.isCompleted.toggle()
			tableView.reloadData()
			complete(true)
		}
		
		let configuration = UISwipeActionsConfiguration(actions: [isCompletedAction])
		configuration.performsFirstActionWithFullSwipe = true
		
		return configuration
	}
}

// Header & number Of Rows In Section
extension TaskListViewController {
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		
		sectionForTaskManager.getSectionsTitles().count
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		sectionForTaskManager.getTasksForSection(section: section).count
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		sectionForTaskManager.getSectionsTitles()[section]
	}
	
	override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		
		guard let header = view as? UITableViewHeaderFooterView else { return }
		header.textLabel?.textColor = .white
		header.textLabel?.frame = header.bounds
		header.textLabel?.textAlignment = .center
	}
}

extension TaskListViewController: IView {
	
	/// Render view cell
	/// - Parameter viewData: ViewData(image, text, secondaryText)
	public func render(viewData: ViewData) {
		
		contentConfiguration.image = viewData.image
		contentConfiguration.text = viewData.text
		contentConfiguration.secondaryText = viewData.secondaryText
		
		if contentConfiguration.image == UIImage(systemName: "checkmark.circle") {
			contentConfiguration.imageProperties.tintColor = .systemGreen
		} else {
			contentConfiguration.imageProperties.tintColor = .black
		}
	}
}

extension TaskListViewController {
	
	private func createCell(currentTask: Task) -> ViewData {
		
		let image: UIImage?
		let text: String?
		var secondaryText: String? = nil
		
		if currentTask.isCompleted {
			image = UIImage(systemName: "checkmark.circle")
		} else {
			image = UIImage(systemName: "circle")
		}
		
		if let currentTask = currentTask as? ImportantTask {
			
			text = "\(currentTask.priority) \(currentTask.name)"
			secondaryText = "DeadLine: \(currentTask.date.formatted())"
		} else {
			text = "\(currentTask.name)"
		}
		
		return ViewData(image: image, text: text, secondaryText: secondaryText)
	}
}
