//
//  Observable.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 02.02.2024.
//

import Foundation

class Observable<T> {
    
    typealias Listener = (T?) -> Void
    private var listener: Listener?
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(_ listener: Listener?) {
        listener?(value)
        self.listener = listener
    }
}
