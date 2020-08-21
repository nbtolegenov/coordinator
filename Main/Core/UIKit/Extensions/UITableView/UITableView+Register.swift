//
//  UITableView+Register.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/20/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import UIKit

extension UITableView {
    func register(cellClass: AnyClass) {
        let nib = UINib(nibName: "\(cellClass)", bundle: Bundle(for: cellClass))
        register(nib, forCellReuseIdentifier: "\(cellClass)")
    }

    func register(aClass: AnyClass) {
        let nib = UINib(nibName: "\(aClass)", bundle: Bundle(for: aClass))
        register(nib, forHeaderFooterViewReuseIdentifier: "\(aClass)")
    }
}
