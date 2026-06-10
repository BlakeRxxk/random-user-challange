//
//  Logger.swift
//  RUCCore
//

import Foundation

// MARK: - Logger

public protocol Logger: Sendable {
    func log(_ message: String, level: LogLevel)
}

// MARK: - LogLevel

public enum LogLevel: Sendable {
    case debug
    case info
    case warning
    case error
}
