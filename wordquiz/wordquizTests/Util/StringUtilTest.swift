//
//  StringUtilTest.swift
//  wordQuizTests
//
//  Created by Leonardo Thives da Luz Fontes on 1/12/20.
//  Copyright © 2020 Leo Fontes. All rights reserved.
//

import XCTest
@testable import Word_Quiz

class StringUtilTest: XCTestCase {

    func testFormatNumberLeftZero() {
        let expected = "00"
        XCTAssertEqual(StringUtil.formatNumberLeftZero(0), expected)
    }

    func testFormatNumberLeftLessThan10() {
        let expected = "09"
        XCTAssertEqual(StringUtil.formatNumberLeftZero(9), expected)
    }

    func testFormatNumberLeftOver10() {
        let expected = "11"
        XCTAssertEqual(StringUtil.formatNumberLeftZero(11), expected)
    }

    
}
