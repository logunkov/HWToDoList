//
//  ToDoListCell.swift
//  ToDoList
//
//  Created by Constantin on 12.02.2023.
//

import UIKit

/// Ячейка для ToDoList.
final class ToDoListCell: UITableViewCell {

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.backgroundColor = .white
	}

	required init?(coder: NSCoder) {

		fatalError("Ooopps")
	}
}
