//
//  Routable.swift
//  RUCCore
//

import Foundation

public protocol Routable {
    var url: URL { get }
    var extraHTTPHeaders: [String: String] { get }
}
