//
//  TimeUtilTest.swift
//  wordQuizTests
//
//  Created by Leonardo Thives da Luz Fontes on 1/12/20.
//  Copyright © 2020 Leo Fontes. All rights reserved.
//

import XCTest
@testable import Word_Quiz

class TimeUtilTest: XCTestCase {

    func testFormatCountdownTimeZero() {
        let expected = "00:00"
        XCTAssertEqual(TimeUtil.formatCountdownTime(timeInSecs: 0), expected)
    }
    
    func testFormatCountdownTimeUnderMinute() {
        let expected = "00:59"
        XCTAssertEqual(TimeUtil.formatCountdownTime(timeInSecs: 59), expected)
    }

    func testFormatCountdownTimeMinute() {
        let expected = "01:00"
        XCTAssertEqual(TimeUtil.formatCountdownTime(timeInSecs: 60), expected)
    }
}
