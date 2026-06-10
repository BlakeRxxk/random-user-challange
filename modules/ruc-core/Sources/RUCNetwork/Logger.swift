//
//  Logger.swift
//  RUCCore
//

import Foundation

public protocol Logger: Sendable {
    func log(_ message: String, level: LogLevel)
}

public enum LogLevel: Sendable {
    case debug
    case info
    case warning
    case error
}
