//
//  Enums.swift
//  MoodNotes
//
//  Created by Utkarsh Dixit on 26/7/21.
//

import Foundation


//MARK: -Error Enum-
enum Status{
    case success, failure
}

//MARK: -NoteType Enum-
enum NoteType{
    case new, existing
}

//MARK: - MOOD Enum-

enum Rate: CaseIterable {
    case bad
    case normal
    case good

    static var allCases: [Rate] {
        return [.bad, .normal, .good]
    }

    var keyTime: Float {
        switch self {
            case .bad:
                return 0
            case .normal:
                return 0.5
            case .good:
                return 1
        }
    }
}

extension Rate {
    var title: String {
        switch self {
        case .bad:
            return "Hideous"
        case .normal:
            return "Okayish"
        case .good:
            return "Great"
        }
    }
}

//MARK: - SETTINGS Enum-

enum SettingType{
    case app
    case system
    case url
    case mail
}

