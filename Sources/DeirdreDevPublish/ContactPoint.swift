//
//  ContactPoint.swift
//  
//
//  Created by Deirdre Saoirse Moen on 4/25/21.
//
import Foundation
import Plot
import Publish

public enum ContactPoint {
    case twitter, email, dev, linkedIn, gitHub, stackoverflow

    func url(_ handler: String) -> String {
        switch self {
        case .twitter:
            return "https://twitter.com/\(handler)"
        case .email:
            return "mailto:\(handler)"
        case .dev:
            return "https://dev.to/\(handler)"
        case .linkedIn:
            return "https://www.linkedin.com/in/\(handler)/"
        case .gitHub:
            return "https://github.com/\(handler)"
        case .stackoverflow:
            return "https://stackoverflow.com/users/\(handler)"
        }
    }

    var icon: String {
        switch self {
        case .twitter:
            return "fa-twitter"
        case .email:
            return "fa-envelope"
        case .dev:
            return "fa-dev"
        case .linkedIn:
            return "fa-linkedin"
        case .gitHub:
            return "fa-github"
        case .stackoverflow:
            return "fa-stack-overflow"
        }
    }

    func alt(_ handler: String) -> String {
        switch self {
        case .twitter:
            return "Twitter: \(handler)"
        case .email:
            return "Email: \(handler)"
        case .dev:
            return "Dev.to: \(handler)"
        case .linkedIn:
            return "Linked In: \(handler)"
        case .gitHub:
            return "Github: \(handler)"
        case .stackoverflow:
            return "Stack Overflow: \(handler)"
        }
    }
}
