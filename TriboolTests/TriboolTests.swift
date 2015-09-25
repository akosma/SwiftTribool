//
//  TriboolTests.swift
//  TriboolTests
//
//  Created by Adrian on 24/09/15.
//  Copyright © 2015 Adrian Kosmaczewski. All rights reserved.
//

import XCTest

@testable import Tribool

class TriboolTests: XCTestCase {
    
    func TriboolAssertEqual(a: Tribool, _ b: Bool, _ text: String) {
        XCTAssertEqual(a == b, Tribool.True, text)
        XCTAssertEqual(b == a, Tribool.True, text)
        XCTAssertEqual(a != b, Tribool.False, text)
        XCTAssertEqual(b != a, Tribool.False, text)
    }
    
    func TriboolAssertEqual(a: Tribool, _ b: Tribool, _ text: String) {
        XCTAssertEqual(a == b, Tribool.True, text)
        XCTAssertEqual(b == a, Tribool.True, text)
        XCTAssertEqual(a != b, Tribool.False, text)
        XCTAssertEqual(b != a, Tribool.False, text)
    }
    
    func TriboolAssertIndeterminate(a: Tribool, _ b: Tribool, _ text: String) {
        XCTAssertEqual(a == b, Tribool.Indeterminate, text)
    }
    
    func testCanBuildFalseValues() {
        let f = Tribool.False
        let g = Tribool(false)
        TriboolAssertEqual(f, g, "Both should be equal")
        TriboolAssertEqual(g, false, "Using the equality operator too")
        
        let h = Tribool(0)
        TriboolAssertEqual(f, h, "Both should be equal")
        TriboolAssertEqual(h, false, "Using the equality operator too")
        
        let i = Tribool("false")
        TriboolAssertEqual(f, i, "Both should be equal")
        TriboolAssertEqual(i, false, "Using the equality operator too")
        
        if let boolValue = f.boolValue {
            XCTAssertFalse(boolValue, "This value should be false")
        }
        else {
            XCTFail("We should not be here")
        }

        if let boolValue = g.boolValue {
            XCTAssertFalse(boolValue, "This value should be false")
        }
        else {
            XCTFail("We should not be here")
        }

        if let boolValue = h.boolValue {
            XCTAssertFalse(boolValue, "This value should be false")
        }
        else {
            XCTFail("We should not be here")
        }

        if let boolValue = i.boolValue {
            XCTAssertFalse(boolValue, "This value should be false")
        }
        else {
            XCTFail("We should not be here")
        }
    }
    
    func testCanBuildTrueValues() {
        let f = Tribool.True
        let g = Tribool(true)
        TriboolAssertEqual(f, g, "Both should be equal")
        TriboolAssertEqual(g, true, "Using the equality operator too")
        
        let h = Tribool(1)
        TriboolAssertEqual(f, h, "Both should be equal")
        TriboolAssertEqual(h, true, "Using the equality operator too")

        let i = Tribool("true")
        TriboolAssertEqual(f, i, "Both should be equal")
        TriboolAssertEqual(i, true, "Using the equality operator too")

        if let boolValue = f.boolValue {
            XCTAssertTrue(boolValue, "This value should be true")
        }
        else {
            XCTFail("We should not be here")
        }
        
        if let boolValue = g.boolValue {
            XCTAssertTrue(boolValue, "This value should be true")
        }
        else {
            XCTFail("We should not be here")
        }
        
        if let boolValue = h.boolValue {
            XCTAssertTrue(boolValue, "This value should be true")
        }
        else {
            XCTFail("We should not be here")
        }
        
        if let boolValue = i.boolValue {
            XCTAssertTrue(boolValue, "This value should be true")
        }
        else {
            XCTFail("We should not be here")
        }
    }
    
    func testCanBuildIndeterminateValues() {
        let f = Tribool.Indeterminate
        let g = Tribool(2)
        TriboolAssertIndeterminate(f, g, "Both should be indeterminate")
        
        let h = Tribool("whatever")
        TriboolAssertIndeterminate(f, h, "Both should be indeterminate")
    
        if let _ = f.boolValue {
            XCTFail("We should not be here")
        }
        
        if let _ = g.boolValue {
            XCTFail("We should not be here")
        }
        
        if let _ = h.boolValue {
            XCTFail("We should not be here")
        }
    }
    
    func testComparisonWithIndeterminateYieldsIndeterminate() {
        let f = Tribool.Indeterminate
        let g = Tribool.True
        let h = Tribool.False
        
        TriboolAssertIndeterminate(f, g, "A comparison with indeterminate yields indeterminate")
        TriboolAssertIndeterminate(g, f, "A comparison with indeterminate yields indeterminate")
        TriboolAssertIndeterminate(f, h, "A comparison with indeterminate yields indeterminate")
        TriboolAssertIndeterminate(h, f, "A comparison with indeterminate yields indeterminate")
    }
    
    func testCanCompareWithStrings() {
        let f = Tribool.Indeterminate
        let g = Tribool.True
        let h = Tribool.False
        
        XCTAssertEqual(f == "whatever", Tribool.Indeterminate, "Comparison with text values should work")
        XCTAssertEqual("whatever" == f, Tribool.Indeterminate, "Comparison with text values should work")
        XCTAssertEqual(g == "true", Tribool.True, "Comparison with text values should work")
        XCTAssertEqual("true" == g, Tribool.True, "Comparison with text values should work")
        XCTAssertEqual(h == "false", Tribool.True, "Comparison with text values should work")
        XCTAssertEqual("false" == h, Tribool.True, "Comparison with text values should work")
    }
    
    func testCanNegate() {
        let f = Tribool.Indeterminate
        let g = Tribool.True
        let h = Tribool.False

        TriboolAssertIndeterminate(!f, f, "The negation of indeterminate is indeterminate")
        TriboolAssertEqual(!g, h, "The negation of True is False")
        TriboolAssertEqual(!h, g, "The negation of False is True")
    }
    
    func testCanAND() {
        let f = Tribool.Indeterminate
        let g = Tribool.True
        let h = Tribool.False

        // False is the absorbing element in this operation
        TriboolAssertEqual(h && h, h, "False && False == False")
        TriboolAssertEqual(h && f, h, "False && Indeterminate == False")
        TriboolAssertEqual(h && g, h, "False && True == False")

        TriboolAssertEqual(h && false, h, "False && false == False")
        TriboolAssertEqual(h && true, h, "False && true == False")
        
        TriboolAssertEqual(false && h, h, "false && False == False")
        TriboolAssertEqual(true && h, h, "true && False == False")
        
        TriboolAssertEqual(h && "false", h, "False && False == False")
        TriboolAssertEqual(h && "whatever", h, "False && Indeterminate == False")
        TriboolAssertEqual(h && "true", h, "False && True == False")
        
        // True is the identity element in this operation
        TriboolAssertEqual(g && h, h, "True && False == False")
        TriboolAssertEqual(g && g, g, "True && True == True")
        TriboolAssertIndeterminate(g && f, h, "True && Indeterminate == Indeterminate")

        TriboolAssertEqual(f && h, h, "Indeterminate && False == False")
        TriboolAssertIndeterminate(f && g, f, "Indeterminate && True == Indeterminate")
        TriboolAssertIndeterminate(f && f, f, "Indeterminate && Indeterminate == Indeterminate")
    }

    func testCanOR() {
        let f = Tribool.Indeterminate
        let g = Tribool.True
        let h = Tribool.False
        
        // False is the identity element in this operation
        TriboolAssertEqual(h || h, h, "False || False == False")
        TriboolAssertIndeterminate(h || f, f, "False || Indeterminate == Indeterminate")
        TriboolAssertEqual(h || g, g, "False || True == True")
        
        TriboolAssertEqual(h || false, h, "False || false == False")
        TriboolAssertEqual(h || true, g, "False || true == True")
        
        TriboolAssertEqual(false || h, h, "false || False == False")
        TriboolAssertEqual(true || h, g, "true || False == True")
        
        TriboolAssertEqual(h || "false", h, "False || False == False")
        TriboolAssertIndeterminate(h || "whatever", f, "False || Indeterminate == Indeterminate")
        TriboolAssertEqual(h || "true", g, "False || True == True")
        
        // True is the absorbing element in this operation
        TriboolAssertEqual(g || h, g, "True || False == True")
        TriboolAssertEqual(g || g, g, "True || True == True")
        TriboolAssertEqual(g || f, g, "True || Indeterminate == True")
        
        TriboolAssertIndeterminate(f || h, f, "Indeterminate || False == Indeterminate")
        TriboolAssertEqual(f || g, g, "Indeterminate || True == True")
        TriboolAssertIndeterminate(f || f, f, "Indeterminate || Indeterminate == Indeterminate")
    }
}
