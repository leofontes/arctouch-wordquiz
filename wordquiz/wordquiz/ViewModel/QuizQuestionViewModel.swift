//
//  QuizQuestionViewModel.swift
//  wordQuiz
//
//  Created by Leonardo Fontes on 1/11/20.
//  Copyright © 2020 Leo Fontes. All rights reserved.
//

import Foundation

class QuizQuestionViewModel {
    let questionNumber: Int
    let delegate: QuizQuestionVMFetchDelegate
    var question: Question?
    var userAnswers = [String]()
    
    init(questionNumber: Int, delegate: QuizQuestionVMFetchDelegate) {
        self.questionNumber = questionNumber
        self.delegate = delegate
        
        fetchQuestion(questionNumber: questionNumber)
    }
    
    func fetchQuestion(questionNumber: Int) {
        if let url = URL(string: "\(SyncService.BASE_URL)/quiz/\(questionNumber)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, taskError) in
                if let safeTaskError = taskError {
                    self.delegate.didFailWithError(error: safeTaskError)
                    return
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let question = try decoder.decode(Question.self, from: safeData)
                        self.delegate.didFetchQuestion(question: question)
                    } catch {
                        self.delegate.didFailWithError(error: error)
                    }
                }
            }
            task.resume()
        } else {
            delegate.didFail()
        }
    }
}

//extension QuizQuestionViewModel : QuestionSyncDelegate {
//    func didFetchQuestion(question: Question) {
//        self.question = question
//    }
//
//    func didFailWithError(error: Error) {
//        //TODO handle error
//    }
//}

protocol QuizQuestionVMFetchDelegate {
    func didFetchQuestion(question: Question)
    func didFailWithError(error: Error)
    func didFail()
}
