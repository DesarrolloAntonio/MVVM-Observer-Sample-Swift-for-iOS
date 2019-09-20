//
//  DynamicValue.swift
//  MVVM+ObserverSample
//
//  Created by Antonio Corrales on 04/09/2019.
//  Copyright © 2019 DesarrolloManzana. All rights reserved.
//

import Foundation


class DynamicValue<T> {
    
    typealias CompletionHandler = ((T?) -> Void)
    
    var value : T? {
        didSet {
            self.notify()
        }
    }
    
    private var observers = [String: CompletionHandler]()
    
    init( value: T?) {
        self.value = value
    }
    
    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }
    
    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify() {
        observers.forEach({ $0.value(value) })
    }
    
    deinit {
        observers.removeAll()
    }
}
