//
//  Bindable.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/6/2.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import Foundation
class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    var observer: ((T?) -> ())?
    func bind(observer: @escaping (T?) ->()){
        self.observer = observer
    }
}
