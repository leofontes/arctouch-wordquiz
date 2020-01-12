//
//  QuizQuestionViewModel.swift
//  wordQuizTests
//
//  Created by Leonardo Thives da Luz Fontes on 1/12/20.
//  Copyright © 2020 Leo Fontes. All rights reserved.
//

import XCTest
@testable import Word_Quiz

class QuizQuestionViewModelTest: XCTestCase {

    let viewModel = QuizQuestionViewModel(questionNumber: 1)
    
    override func setUp() {
        viewModel.question = Question(question: "Is ArcTouch great?", answer: ["yes", "for sure", "hell yes", "yeah"])
    }

    func testGetQuestionCount() {
        let expected = "00/04"
        XCTAssertEqual(viewModel.getQuestionCount(), expected)
    }

    func testCheckAnswer() {
        XCTAssertTrue(viewModel.checkAnswer("yes"))
        XCTAssertFalse(viewModel.checkAnswer("yes"))
        XCTAssertFalse(viewModel.checkAnswer("no"))
    }
    
    func testCheckAnswerCaps() {
        XCTAssertTrue(viewModel.checkAnswer("YES"))
    }
}
