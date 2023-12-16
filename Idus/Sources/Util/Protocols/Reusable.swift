//
//  Reusable.swift
//  Idus
//
//  Created by 강창혁 on 12/4/23.
//

import Foundation

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
