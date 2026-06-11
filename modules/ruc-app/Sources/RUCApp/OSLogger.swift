//
//  OSLogger.swift
//  RUCApp
//

import OSLog
import RUCCore
import RUCNetwork

// MARK: - OSLogger

final class OSLogger: RUCNetwork.Logger {

    // MARK: Internal

    func log(_ message: String, level: LogLevel) {
        switch level {
        case .debug:
            logger.debug("\(message)")
        case .info:
            logger.info("\(message)")
        case .warning:
            logger.warning("\(message)")
        case .error:
            logger.error("\(message)")
        }
    }

    // MARK: Private

    private let logger = Logger()

}
