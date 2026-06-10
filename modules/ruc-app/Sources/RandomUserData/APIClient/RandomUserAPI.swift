//
//  RandomUserAPI.swift
//  RandomUserData
//

import Foundation
import RUCCore
import RUCNetwork

// MARK: - RandomUserAPI

enum RandomUserAPI {

    case userList

    static let baseURL = URL(staticString: "https://api.randomuser.me/api")

}

// MARK: Routable

extension RandomUserAPI: Routable {

    var url: URL {
        let path =
            switch self {
            case .userList: "/"
            }
        return URL(string: path, relativeTo: RandomUserAPI.baseURL)!
    }

    var extraHTTPHeaders: [String: String] {
        [String: String]()
    }

}
