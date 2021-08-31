//
//  SettingsModel.swift
//  MoodNotes
//
//  Created by Utkarsh Dixit on 28/7/21.
//

import Foundation
import UIKit

struct SettingsOption{
    var icon: UIImage
    var name: String
    var type: SettingType
    var url: String?
}

struct SettingsGroup{
    var options: [SettingsOption]
    var title: String
}

struct Settings{
    static let setinngs: [SettingsGroup] = [Groups.prefrences, Groups.support, Groups.connect, Groups.other]
}

struct Groups{
    static let prefrences = SettingsGroup(options: Options.prefrenceOptions, title: "Preferences")
    static let support = SettingsGroup(options: Options.supportOptions, title: "Help and Support")
    static let connect = SettingsGroup(options: Options.connectOptions, title: "Share and Connect")
    static let other = SettingsGroup(options: Options.otherOptions, title: "Others")
}

struct Options{
    static let prefrenceOptions = [SettingsOption(icon: UIImage(named: "Notification")!, name: "Notifications", type: .system, url: nil),                                     SettingsOption(icon: UIImage(named: "Haptics")!, name: "Haptics", type: .app, url: nil),
                                   SettingsOption(icon: UIImage(named: "Theme")!, name: "Theme", type: .app, url: nil)]
    
    static let supportOptions = [SettingsOption(icon: UIImage(named: "Help")!, name: "Help & Support", type: .mail, url: nil),                                              SettingsOption(icon: UIImage(named: "FeatureRequest")!, name: "Feature Request", type: .mail, url: nil),
                                 SettingsOption(icon: UIImage(named: "ContactUs")!, name: "Contact Us", type: .mail, url: nil)]
    
    static let connectOptions = [SettingsOption(icon: UIImage(named: "Share")!, name: "Share with Friends", type: .app, url: nil),                                          SettingsOption(icon: UIImage(named: "Insta")!, name: "Instagram", type: .url, url: ""),
                                 SettingsOption(icon: UIImage(named: "Twitter")!, name: "Twitter", type: .url, url: "")]
    
    static let otherOptions = [SettingsOption(icon: UIImage(named: "Faq")!, name: "FAQ", type: .url, url: ""),                                                            SettingsOption(icon: UIImage(named: "Privacy")!, name: "Privacy Policy", type: .url, url: ""),
                               SettingsOption(icon: UIImage(named: "Developer")!, name: "Developer Info", type: .url, url: "")]
}

