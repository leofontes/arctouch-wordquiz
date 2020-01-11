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
        
        fetchQuestion()
    }
    
    func fetchQuestion() {
        if let url = URL(string: "\(SyncService.BASE_URL)/quiz/\(questionNumber)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, taskError) in
                if let safeTaskError = taskError {
                    self.delegate.didFail(error: safeTaskError)
                    return
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let question = try decoder.decode(Question.self, from: safeData)
                        self.question = question
                        self.delegate.didFetchQuestion(question: question)
                    } catch {
                        self.delegate.didFail(error: error)
                    }
                }
            }
            task.resume()
        } else {
            delegate.didFail(error: nil)
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
    func didStartFetching()
    func didFetchQuestion(question: Question)
    func didFail(error: Error?)
}
