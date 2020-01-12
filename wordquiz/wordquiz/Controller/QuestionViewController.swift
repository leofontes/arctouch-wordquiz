//
//  QuestionViewController.swift
//  wordQuiz
//
//  Created by Leonardo Fontes on 1/11/20.
//  Copyright © 2020 Leo Fontes. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var answerTableView: UITableView!
    @IBOutlet weak var questionCountLabel: UILabel!
    @IBOutlet weak var timeCountdownLabel: UILabel!
    
    var viewModel: QuizQuestionViewModel!
    var countdownTime: Int = TimeUtil.QUIZ_LENGTH_TIME
    var timer: Timer = Timer()
    var quizRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        answerTextField.delegate = self
        answerTableView.dataSource = self
        answerTableView.delegate = self
        
        viewModel = QuizQuestionViewModel(questionNumber: 1, delegate: self)
    }

    func presentQuizEndedAlert(success: Bool) {
        let title = success ? "Congratulations" : "Time finished"
        let message = success ? "Good job! You found all the answers on time. Keep up with the great work." : "Sorry, time is up! You got \(viewModel.userAnswers.count) out of \(viewModel.question!.answer.count) answers."
        let buttonText = success ? "Play again" : "Try again"

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: { (alertAction) in
            self.restartQuiz()
        }))
    
        self.present(alert, animated: true)
    }
    
    func restartQuiz() {
        timer.invalidate()
        quizRunning = true
        countdownTime = TimeUtil.QUIZ_LENGTH_TIME
        viewModel.userAnswers.removeAll()
        answerTableView.reloadData()
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { closureTimer in
                if self.countdownTime > 0 {
                    self.timeCountdownLabel.text = TimeUtil.formatCountdownTime(timeInSecs: self.countdownTime)
                    self.countdownTime -= 1
                } else {
                    self.timer.invalidate()
                    self.quizRunning = false
                    self.presentQuizEndedAlert(success: false)
                }
            }
        }
    }
    
    @IBAction func onStartButtonPress(_ sender: UIButton) {
        sender.setTitle("Reset", for: .normal)
        restartQuiz()
    }
}

extension QuestionViewController : QuizQuestionVMFetchDelegate {
    func didFetchQuestion(question: Question) {
        DispatchQueue.main.async {
            //TODO dismiss overlay
            self.questionLabel.text = question.question
            self.questionCountLabel.text = self.viewModel.getQuestionCount()
        }
    }
    
    func didFail(error: Error?) {
        let alert = UIAlertController(title: "Oops", message: "Something went wrong.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reload", style: .default, handler: { _ in
            self.viewModel = QuizQuestionViewModel(questionNumber: 1, delegate: self)
        }))
        self.present(alert, animated: true)
    }
    
    func didStartFetching() {
        //TODO handle overlay
    }
}

extension QuestionViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userAnswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = answerTableView.dequeueReusableCell(withIdentifier: "answerTableViewCell", for: indexPath) as? AnswerTableViewCell {
            cell.configure(answer: viewModel.userAnswers[viewModel.userAnswers.count - indexPath.row - 1])
            return cell
        }
        return AnswerTableViewCell()
    }
}

extension QuestionViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSubmit(answer: textField.text ?? "")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        handleSubmit(answer: textField.text ?? "")
    }
    
    func handleSubmit(answer: String) {
        answerTextField.text = ""
        if viewModel.checkAnswer(answer) {
            questionCountLabel.text = viewModel.getQuestionCount()
            answerTableView.reloadData()
            
            if viewModel.userAnswers.count == viewModel.question!.answer.count {
                timer.invalidate()
                self.quizRunning = false
                presentQuizEndedAlert(success: true)
            }
        } else {
            answerTextField.shake()
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if quizRunning {
            return true
        }
        let alert = UIAlertController(title: "Not so fast!", message: "You need to start the quiz to begin answering", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Start quiz", style: .default, handler: { (alert) in
            self.restartQuiz()
        }))
        self.present(alert, animated: true)
        return false
    }
}
