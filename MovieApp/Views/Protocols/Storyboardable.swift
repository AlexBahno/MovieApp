//
//  Storyboardable.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 31.01.2024.
//

import Foundation
import UIKit

protocol Storyboardable {
    static func createObject() -> Self
}

extension Storyboardable where Self: UIViewController {
    static func createObject() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: id, bundle: nil)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}
