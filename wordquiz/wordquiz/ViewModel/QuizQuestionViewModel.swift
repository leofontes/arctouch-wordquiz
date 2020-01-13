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
    var delegate: QuizQuestionVMFetchDelegate?
    var question: Question?
    var userAnswers = [String]()
    
    init(questionNumber: Int) {
        self.questionNumber = questionNumber
    }
    
    func fetchQuestion() {
        if let _delegate = delegate {
            _delegate.didStartFetching()
            if let url = URL(string: "\(SyncService.BASE_URL)/quiz/\(questionNumber)") {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, taskError) in
                    if let safeTaskError = taskError {
                        _delegate.didFail(error: safeTaskError)
                        return
                    }
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        do {
                            let question = try decoder.decode(Question.self, from: safeData)
                            self.question = question
                            _delegate.didFetchQuestion(question: question)
                        } catch {
                            _delegate.didFail(error: error)
                        }
                    }
                }
                task.resume()
            } else {
                _delegate.didFail(error: nil)
            }
        }
    }
    
    func getQuestionCount() -> String {
        guard let fetchedQuestion = question else {
            return ""
        }
        return "\(StringUtil.formatNumberLeftZero(userAnswers.count))/\(StringUtil.formatNumberLeftZero(fetchedQuestion.answer.count))"
    }
    
    func checkAnswer(_ answer: String) -> Bool {
        guard let fetchedQuestion = question else {
            return false
        }
        let lowercaseAnswer = answer.lowercased()
        
        if fetchedQuestion.answer.contains(lowercaseAnswer) && !userAnswers.contains(lowercaseAnswer.capitalized) {
            userAnswers.append(answer.capitalized)
            return true
        }
        return false
    }
}

protocol QuizQuestionVMFetchDelegate {
    func didStartFetching()
    func didFetchQuestion(question: Question)
    func didFail(error: Error?)
}
