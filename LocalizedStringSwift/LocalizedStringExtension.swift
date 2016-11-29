//
//  LocalizedString.swift
//
//  Created by Kenta Nakae on 11/17/16.
//  Copyright © 2016 digitrick. All rights reserved.
//

import Foundation

/// LocalizableString Protocol String Extension
extension String: LocalizableString {    
    public func localized(key: String, language: String = defaultLanguageIdentifier, tableName: String? = defaultTableName, bundle: Bundle = defaultBundle, comment: String = "") -> String {
        
        var targetBundlePath = bundle.path(forResource: language, ofType: "lproj") ?? defaultBundle.bundlePath
        var targetBundle = Bundle(path: targetBundlePath) ?? defaultBundle
        
        let localizedString = NSLocalizedString(key, tableName: tableName, bundle: targetBundle, value: key, comment: comment)
        
        if localizedString == key {
            targetBundlePath = bundle.path(forResource: "Base", ofType: "lproj") ?? defaultBundle.bundlePath
            targetBundle = Bundle(path: targetBundlePath) ?? defaultBundle
        }
        
        return NSLocalizedString(key, tableName: tableName, bundle: targetBundle, value: self, comment: comment)
    }
}
