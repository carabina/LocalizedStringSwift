//
//  Localizable.swift
//
//  Created by Kenta Nakae on 11/17/16.
//  Copyright © 2016 digitrick. All rights reserved.
//

import Foundation

/// default language: System or English
public let defaultLanguageIdentifier = Bundle.main.preferredLocalizations.first ?? "en"

/// default table name: Localizable.strings
public let defaultTableName = "Localizable"

/// defaultBundle: main bundle
public let defaultBundle = Bundle.main


/// LocalizableString Protocol
public protocol LocalizableString {
    /// localize string
    ///
    /// - Parameters:
    ///   - key: key
    ///   - language: language identifier
    ///   - tableName: table name
    ///   - bundle: bundle
    ///   - comment: comment
    /// - Returns: localized string
    func localized(key: String, language: String, tableName: String?, bundle: Bundle, comment: String) -> String
}

// MARK: - LocalizableString Protocol Default Extension
public extension LocalizableString {
    public func localized(key: String, language: String = defaultLanguageIdentifier, tableName: String? = defaultTableName, bundle: Bundle = defaultBundle, comment: String = "") -> String {
        
        var targetBundlePath = bundle.path(forResource: language, ofType: "lproj") ?? defaultBundle.bundlePath
        var targetBundle = Bundle(path: targetBundlePath) ?? defaultBundle
        
        let localizedString = NSLocalizedString(key, tableName: tableName, bundle: targetBundle, value: key, comment: comment)
        
        if localizedString == key {
            targetBundlePath = bundle.path(forResource: "Base", ofType: "lproj") ?? defaultBundle.bundlePath
            targetBundle = Bundle(path: targetBundlePath) ?? defaultBundle
        }
        
        return NSLocalizedString(key, tableName: tableName, bundle: targetBundle, value: key, comment: comment)
    }
}
