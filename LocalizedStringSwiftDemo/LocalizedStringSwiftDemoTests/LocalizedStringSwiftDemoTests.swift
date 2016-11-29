//
//  LocalizedStringSwiftDemoTests.swift
//  LocalizedStringSwiftDemoTests
//
//  Created by Kenta Nakae on 11/29/16.
//  Copyright © 2016 digitrick. All rights reserved.
//

import XCTest
@testable import LocalizedStringSwiftDemo
import LocalizedStringSwift

class LocalizedStringSwiftDemoTests: XCTestCase {
    
    let testBundle = Bundle(for: LocalizedStringSwiftDemoTests.self)
    let language = LocalizedString.language
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDefaultLanguage() {
        print(language.defaultIdentifier)
        print(language.defaultDisplayName)
    }
    
    func testLocalizableLanguage() {
        print(language.localizableIdentifiers)
        print(language.localizableDisplayNames)
    }
    
    func testCurrentIdentifier() {
        // change to Japanese
        language.currentIdentifier = "ja"
        XCTAssertEqual(language.currentIdentifier, "ja")
        XCTAssertEqual(language.currentDisplayName, "日本語")
        
        // "test1" doesn't exist. Nothing changes.
        language.currentIdentifier = "test1"
        XCTAssertNotEqual(language.currentIdentifier, "test")
        print(language.currentIdentifier)
        
        // reset to default
        language.resetLanguage()
        XCTAssertEqual(language.currentIdentifier, defaultLanguageIdentifier)
        print(language.currentIdentifier)
        
        // change to English
        language.currentIdentifier = "en"
        XCTAssertEqual(language.currentIdentifier, "en")
        XCTAssertEqual(language.currentDisplayName, "English")
        
        // "test2" doesn't exist. Nothing changes.
        language.currentIdentifier = "test2"
        XCTAssertNotEqual(language.currentIdentifier, "test")
        XCTAssertEqual(language.currentIdentifier, "en")
        print(language.currentIdentifier)
    }
    
    func testEnglishDisplayName() {
        if language.defaultIdentifier == "en" {
            XCTAssertEqual(language.defaultDisplayName, "English")
            XCTAssertEqual(language.displayName(byId: "Base"), "English")
            XCTAssertNotEqual(language.displayName(byId: "Test"), "English")
            XCTAssertEqual(language.displayName(byId: "Test"), "")
        }
    }
    
    func testJapaneseDisplayName() {
        if language.defaultIdentifier == "ja" {
            XCTAssertEqual(language.defaultDisplayName, "日本語")
            XCTAssertEqual(language.displayName(byId: "Base"), "日本語")
            XCTAssertNotEqual(language.displayName(byId: "Test"), "日本語")
            XCTAssertEqual(language.displayName(byId: "Test"), "")
        }
    }
    
    func testEnglishStringLocalized() {
        if language.defaultIdentifier == "en" {
            // Localizable.strings(YOUR LANGUAGE) has "title".
            var str = "DefaultTitle".localized(key: "title", language: defaultLanguageIdentifier, tableName: defaultTableName, bundle: testBundle, comment: "title")
            XCTAssertNotEqual(str, "DefaultTitle")
            XCTAssertEqual(str, "localized title")
            
            // Localizable.strings(YOUR LANGUAGE) has "title".
            str = "DefaultTitle".localized(key: "title", bundle: testBundle)
            XCTAssertNotEqual(str, "DefaultTitle")
            XCTAssertEqual(str, "localized title")
            
            // Localizable.strings(Japanese) has "title".
            str = "DefaultTitle".localized(key: "title", language: "ja", bundle: testBundle, comment: "title")
            XCTAssertNotEqual(str, "DefaultTitle")
            XCTAssertEqual(str, "ローカライズされたタイトル")
            
            // Test.strings(YOUR LANGUAGE) doesn't have "title".
            str = "DefaultTitle".localized(key: "title", tableName: "Test", bundle: testBundle)
            XCTAssertEqual(str, "DefaultTitle")
            
            // Test.strings(Japanese) has "title".
            str = "DefaultTitle".localized(key: "title", language: "ja", tableName: "Test", bundle: testBundle)
            XCTAssertNotEqual(str, "DefaultTitle")
            XCTAssertEqual(str, "テスト")
            
            // Test.strings(YOUR LANGUAGE) doesn't have "tableName". but Test.strings(Base) has it.
            str = "BaseTableName".localized(key: "tableName", tableName: "Test", bundle: testBundle)
            XCTAssertNotEqual(str, "BaseTableName")
            XCTAssertEqual(str, "Test")
            
            // Test.strings(Japanese) doesn't have "tableName". but Test.strings(Base) has it.
            str = "BaseTableName".localized(key: "tableName", language: "ja", tableName: "Test", bundle: testBundle)
            XCTAssertNotEqual(str, "BaseTableName")
            XCTAssertEqual(str, "Test")
            
            // NonExistent.strings doesn't exist
            str = "DefaultTitle".localized(key: "title", tableName: "NonExistent", bundle: testBundle)
            XCTAssertEqual(str, "DefaultTitle")
        }
    }
    
    func testJapaneseStringLocalized() {
        if language.defaultIdentifier == "ja" {
            // Localizable.strings(YOUR LANGUAGE) has "title".
            var str = "DefaultTitle".localized(key: "title", language: defaultLanguageIdentifier, tableName: defaultTableName, bundle: testBundle, comment: "title")
            XCTAssertNotEqual(str, "DefaultTitle")
            XCTAssertEqual(str, "ローカライズされたタイトル")
            
            // Localizable.strings(YOUR LANGUAGE) has "title".
            str = "DefaultTitle".localized(key: "title", bundle: testBundle)
            XCTAssertNotEqual(str, "DefaultTitle")
            XCTAssertEqual(str, "ローカライズされたタイトル")
            
            // Localizable.strings(Japanese) has "title".
            str = "DefaultTitle".localized(key: "title", language: "en", bundle: testBundle, comment: "title")
            XCTAssertNotEqual(str, "DefaultTitle")
            XCTAssertEqual(str, "localized title")
            
            // Test.strings(Japanese) has "title".
            str = "DefaultTitle".localized(key: "title", language: "ja", tableName: "Test", bundle: testBundle)
            XCTAssertNotEqual(str, "DefaultTitle")
            XCTAssertEqual(str, "テスト")
            
            // Test.strings(YOUR LANGUAGE) doesn't have "tableName". but Test.strings(Base) has it.
            str = "BaseTableName".localized(key: "tableName", tableName: "Test", bundle: testBundle)
            XCTAssertNotEqual(str, "BaseTableName")
            XCTAssertEqual(str, "Test")
            
            // Test.strings(Japanese) doesn't have "tableName". but Test.strings(Base) has it.
            str = "BaseTableName".localized(key: "tableName", language: "ja", tableName: "Test", bundle: testBundle)
            XCTAssertNotEqual(str, "BaseTableName")
            XCTAssertEqual(str, "Test")
            
            // NonExistent.strings doesn't exist
            str = "DefaultTitle".localized(key: "title", tableName: "NonExistent", bundle: testBundle)
            XCTAssertEqual(str, "DefaultTitle")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
