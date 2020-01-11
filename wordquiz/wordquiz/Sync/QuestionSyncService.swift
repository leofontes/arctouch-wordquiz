//
//  QuestionSyncService.swift
//  wordQuiz
//
//  Created by Leonardo Thives da Luz Fontes on 1/10/20.
//  Copyright © 2020 Leo Fontes. All rights reserved.
//

import Foundation
//
//class QuestionSyncService {
//    
//    let delegate: QuestionSyncDelegate
//
//    init(delegate: QuestionSyncDelegate) {
//        self.delegate = delegate
//    }
//
////    func fetch(questionNumber: Int) -> Question {
//    func fetch(questionNumber: Int) {
//        if let url = URL(string: "\(SyncService.BASE_URL)/quiz/\(questionNumber)") {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, taskError) in
//                if taskError != nil {
//                    delegate.didFailWithError(error: taskError)
//                    return
//                }
//                if let safeData = data {
//                    let decoder = JSONDecoder()
//                    do {
//                        let question = try decoder.decode(Question.self, from: safeData)
//                        delegate.didFetchQuestion(question: question)
//                    } catch {
//                        delegate.didFailWithError(error: error)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//}
//
//protocol QuestionSyncDelegate {
//    func didFetchQuestion(question: Question)
//    func didFailWithError(error: Error)
//}

