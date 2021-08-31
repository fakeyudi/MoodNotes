//
//  Constants.swift
//  MoodNotes
//
//  Created by Utkarsh Dixit on 26/7/21.
//

import Foundation
import UIKit

struct names{
    static let appName = "MoodNotes"
    static let mailID = "udixit419@gmail.com"
}

struct urls{
    static let insta = ""
    static let twitter = ""
    static let privacyPolicy = ""
    static let faq = ""
    static let developer = ""
}

struct segues{
    static let newNote = "newNote"
    static let setMood = "setMood"
}

struct Identifiers{
    static let notesCell = "notesCell"
    static let MoodVC = "mood"
    static let settingsCell = "settingsCell"
}

struct moods{
    static let great = "Great"
    static let ok  = "Okayish"
    static let bad = "Hideous"
    static let Default = "" //TODO:- Add Emoji
}

struct MailSubjects{
    static let help = "\(names.appName): Need Help with Something"
    static let feature = "\(names.appName): New Feature Idea"
    static let contact = "\(names.appName): Hey There"
}


