//
//  Question.swift
//  wordQuiz
//
//  Created by Leonardo Thives da Luz Fontes on 1/10/20.
//  Copyright © 2020 Leo Fontes. All rights reserved.
//

import Foundation

struct Question: Decodable {
    let question: String
    let answer: [String]
}
