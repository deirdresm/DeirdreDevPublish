//
//  ContactPoint.swift
//  
//
//  Created by Deirdre Saoirse Moen on 4/25/21.
//
import Foundation
import Plot
import Publish

/// All the various social media labels, URLs, and so forth that you want in your footer.
public enum ContactPoint {
    case mastodon, email, dev, linkedIn, gitHub, stackoverflow

    func url(_ handler: String) -> String {
        switch self {
		case .mastodon:
			return "\(handler)"
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
		case .mastodon:
			return "icon brands fa-mastodon"
        case .email:
            return "icon solid fa-envelope"
        case .dev:
            return "icon brands fa-dev"
        case .linkedIn:
            return "icon brands fa-linkedin"
        case .gitHub:
            return "icon brands fa-github"
        case .stackoverflow:
            return "icon brands fa-stack-overflow"
        }
    }

    func alt(_ handler: String) -> String {
        switch self {
		case .mastodon:
			return "Mastodon: \(handler)"
        case .email:
            return "Email: \(handler)"
        case .dev:
            return "Dev.to: \(handler)"
        case .linkedIn:
            return "Linked In: \(handler)"
        case .gitHub:
            return "GitHub: \(handler)"
        case .stackoverflow:
            return "Stack Overflow: \(handler)"
        }
    }

    func label() -> String {
        switch self {
		case .mastodon:
			return "Mastodon"
        case .email:
            return "Email"
        case .dev:
            return "Dev.to"
        case .linkedIn:
            return "Linked In"
        case .gitHub:
            return "GitHub"
        case .stackoverflow:
            return "Stack Overflow"
        }
    }
}
