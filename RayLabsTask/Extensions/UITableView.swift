//
//  ReusableTableCell.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/19/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import UIKit

protocol ReusableTableCell: UITableViewCell {
    static var identifier: String { get }
}

extension ReusableTableCell where Self: UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableView {
    func registerClass<T: ReusableTableCell>(_ cellClass: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
}

extension UITableViewCell: ReusableTableCell {}

