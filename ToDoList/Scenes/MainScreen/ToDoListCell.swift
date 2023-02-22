//
//  ToDoListCell.swift
//  ToDoList
//
//  Created by Constantin on 12.02.2023.
//

import UIKit

/// ToDoListCell
final class ToDoListCell: UITableViewCell {

	/// Create ToDoListCell
	/// - Parameters:
	///   - style: CellStyle
	///   - reuseIdentifier: String
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.backgroundColor = .white
	}

	/// Create fatalError
	/// - Parameter coder: NSCoder
	required init?(coder: NSCoder) {

		fatalError("Ooopps")
	}
}
