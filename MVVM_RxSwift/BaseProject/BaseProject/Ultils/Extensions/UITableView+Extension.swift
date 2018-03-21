//
//  UITableView+Extension.swift
//  AB Branded App
//

import Foundation

extension UICollectionView
{
    func register(nibName: String, identifier: String)
    {
        self.register(UINib.init(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func register(nibName: String)
    {
        self.register(nibName: nibName, identifier: nibName)
    }
    
    func registerCell(nibNames: [String] ) {
        nibNames.forEach { (nibName) in
            self.register(nibName: nibName, identifier: nibName)
        }
    }
}

extension UITableView
{
    func register(nibName: String, identifier: String)
    {
        self.register(UINib.init(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func register(nibName: String)
    {
        self.register(nibName: nibName, identifier: nibName)
    }
    
    func registerCell(nibNames: [String] ) {
        nibNames.forEach { (nibName) in
            self.register(nibName: nibName, identifier: nibName)
        }
    }
}
extension UITableView
{
    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }
    func setupFullLine()
    {
        if self.responds(to: #selector(getter: self.separatorInset))
        {
            self.separatorInset = .zero
        }
        if self.responds(to: #selector(getter: self.preservesSuperviewLayoutMargins ))
        {
            self.preservesSuperviewLayoutMargins = false
        }
        if self.responds(to: #selector(getter: self.layoutMargins))
        {
            self.layoutMargins = .zero
        }
    }
}
