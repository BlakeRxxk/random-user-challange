//
//  Routable.swift
//  RUCCore
//

import Foundation

public protocol Routable {
    var url: URL { get }
    var extraHTTPHeaders: [String: String] { get }
    var requestBody: [String: Any] { get }
}
