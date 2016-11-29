//
//  AppLocalization.swift
//  LocalizationDemo
//
//  Created by Kenta Nakae on 11/17/16.
//  Copyright © 2016 digitrick. All rights reserved.
//

import Foundation

/// key for UserDefaults
private let currentLocalizedLanguageIdentifier = "LocalizedStringCurrentLocalizedLanguageIdentifier"

public class LocalizedString {

    public static let language = LocalizedString()

    /// languages identifiers in App
    public var localizableIdentifiers: [String] {
        return Bundle.main.localizations
    }
    
    /// language display names in App
    public var localizableDisplayNames: [String] {
        var displayNames = [String]()
        for language in localizableIdentifiers {
            let locale = NSLocale(localeIdentifier: language)
            if let name = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
                displayNames.append(name)
            }
        }
        return displayNames
    }
    
    /// current language identifier
    public var currentIdentifier: String {
        get {
            return UserDefaults.standard.string(forKey: currentLocalizedLanguageIdentifier) ?? defaultIdentifier
        }
        set {
            
            let localizations = Bundle.main.localizations
            if localizations.contains(newValue) {
                UserDefaults.standard.set(newValue, forKey: currentLocalizedLanguageIdentifier)
                UserDefaults.standard.synchronize()
                NotificationCenter.default.post(name: NSNotification.Name(.localizedLanguageChanged), object: newValue)
            }
        }
    }
    
    /// current language display name
    public var currentDisplayName: String {
        return displayName(byId: currentIdentifier)
    }
    
    /// get language display name by language identifier
    ///
    /// - Parameter id: language identifier
    /// - Returns: String: display name
    public func displayName(byId id: String) -> String {
        let locale = NSLocale(localeIdentifier: id)
        if let name = locale.displayName(forKey: NSLocale.Key.identifier, value: id) {
            return name
        } else if id == "Base" {
            return defaultDisplayName
        } else {
            return ""
        }
    }
    
    /// default language identifier
    public var defaultIdentifier: String {
        return Bundle.main.preferredLocalizations.first ?? "en"
    }
    
    /// default language display name
    public var defaultDisplayName: String {
        return displayName(byId: defaultIdentifier)
    }
    
    /// reset to localize
    public func resetLanguage() {
        currentIdentifier = defaultIdentifier
    }
    
    private init(){}
}

// MARK: - Notification Name for Localizable Protocol Extension
public extension NSNotification.Name {
    enum Name: String {
        case localizedLanguageChanged
    }
    
    init(_ name: Name) {
        self = NSNotification.Name(name.rawValue)
    }
}
