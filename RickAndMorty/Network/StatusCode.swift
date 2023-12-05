//
//  StatusCode.swift
//  RickAndMorty
//
//  Created by Eric Margay on 02/12/23.
//

import Foundation

enum StatusCode: Int {
    case unknown = 0
    case info, success, redirection, clientError, serverError

    init?(rawValue: Int) {
        switch rawValue {
        case 100...102:
            self = .info
        case 200...208, 226:
            self = .success
        case 300...308:
            self = .redirection
        case 400...431, 451:
            self = .clientError
        case 500...511:
            self = .serverError
        default:
            self = .unknown
        }
    }
}

