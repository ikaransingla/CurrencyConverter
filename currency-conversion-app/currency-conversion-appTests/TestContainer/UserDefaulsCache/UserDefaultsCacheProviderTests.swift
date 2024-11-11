//
//  UserDefaultsCacheProviderTests.swift
//  currency-conversion-appTests
//
//  Created by Karana Singla on 31/10/24.
//

import XCTest
@testable import currency_conversion_app

class UserDefaultsCacheProviderTests: XCTestCase {
    var cacheProvider: UserDefaultsCacheProvider!
    var mockUserDefaults: UserDefaults!

    override func setUp() {
        super.setUp()
        
        // Initialize UserDefaults with a unique suite name for isolation
        let suiteName = "com.test.CacheProviderTests"
        mockUserDefaults = UserDefaults(suiteName: suiteName)
        
        // Clear any existing data in the mockUserDefaults instance
        mockUserDefaults.removePersistentDomain(forName: suiteName)
        
        // Initialize the UserDefaultsCacheProvider with the mock instance
        cacheProvider = UserDefaultsCacheProvider(userDefaults: mockUserDefaults)
    }

    override func tearDown() {
        super.tearDown()
        
        // Clear the UserDefaults data after each test
        let suiteName = "com.test.CacheProviderTests"
        mockUserDefaults.removePersistentDomain(forName: suiteName)

        
        mockUserDefaults = nil
        cacheProvider = nil
    }

    func testSetAndGetStringValue() {
        let key = "testStringKey"
        let testValue = "Test String"
        
        cacheProvider.set(testValue, forKey: key)
        let retrievedValue: String? = cacheProvider.get(forKey: key)
        
        XCTAssertEqual(retrievedValue, testValue, "Retrieved value should match the stored string")
    }
    
    func testSetAndGetDictionary() {
        let key = "testDictionaryKey"
        let testValue = ["USD": "United States Dollar", "EUR": "Euro"]
        
        cacheProvider.set(testValue, forKey: key)
        let retrievedValue: [String: String]? = cacheProvider.get(forKey: key)
        
        XCTAssertEqual(retrievedValue, testValue, "Retrieved dictionary should match the stored dictionary")
    }

    func testGetNonexistentValue() {
        let retrievedValue: String? = cacheProvider.get(forKey: "nonexistentKey")
        
        XCTAssertNil(retrievedValue, "Retrieving a non-existent key should return nil")
    }

    func testSetAndGetDate() {
        let key = "testDateKey"
        let testDate = Date()
        
        cacheProvider.set(testDate, forKey: key)
        let retrievedDate: Date? = cacheProvider.get(forKey: key)
        
        XCTAssertEqual(retrievedDate, testDate, "Retrieved date should match the stored date")
    }
}
