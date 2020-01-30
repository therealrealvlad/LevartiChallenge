//
//  UITableViewCell+Utilities.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 31/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

/// Reusable protocol
public protocol Reusable: AnyObject {
    /// The resue identifier
    static var reuseIdentifier: String { get }
}

/// Reusable extension
public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

/// Nib typealias
public typealias NibType = UINib

/// NibLoadable protocol
public protocol NibLoadable: AnyObject {
    /// The nib type
    static var nib: NibType { get }
}

/// NibLoadable extension
public extension NibLoadable {
    /// By default, the nib name is the same name as the class and located in the class's bundle
    static var nib: NibType {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

/// NibLoadable extension with Self contraint
public extension NibLoadable where Self: UIView {
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}

/// NibReusable typealias
public typealias NibReusable = Reusable & NibLoadable

public extension UITableView {
    
    /// Registers the given cell type with the collection view, where the cell type conforms to the `NibReusable` protocol
    /// - Parameter cellType: The cell type to register
    final func register<T: UITableViewCell>(cellType: T.Type) where T: NibReusable {
        register(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    /// Registers the given cell type with the collection view, where the cell type conforms to the `Reusable` protocol
    /// - Parameter cellType: The cell type to register
    final func register<T: UITableViewCell>(cellType: T.Type) where T: Reusable {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    
    /// Dequeues the reusable cell, where the cell type conforms to the `Reusable` protocol
    /// - Parameter indexPath: The index path of the cell to dequeue
    /// - Parameter cellType: The type of the cell to dequeue
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with reuseIdentifier \(cellType.reuseIdentifier) matching type \(cellType.self); check configuration and that cell type is registered")
        }
        return cell
    }
}
