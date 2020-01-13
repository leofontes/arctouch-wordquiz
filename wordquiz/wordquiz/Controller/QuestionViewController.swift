//
//  QuestionViewController.swift
//  wordQuiz
//
//  Created by Leonardo Fontes on 1/11/20.
//  Copyright © 2020 Leo Fontes. All rights reserved.
//

import UIKit
import Foundation

class QuestionViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var answerTableView: UITableView!
    @IBOutlet weak var questionCountLabel: UILabel!
    @IBOutlet weak var timeCountdownLabel: UILabel!
    
    var viewModel: QuizQuestionViewModel!
    var countdownTime: Int = TimeUtil.QUIZ_LENGTH_TIME
    var timer: Timer = Timer()
    var quizStatus: QuizStatus = QuizStatus.LOADING
    
    override func viewDidLoad() {
        super.viewDidLoad()

        answerTextField.delegate = self
        answerTableView.dataSource = self
        answerTableView.delegate = self
        
        addTextFieldPadding()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel = QuizQuestionViewModel(questionNumber: 1)
        viewModel.delegate = self
        viewModel.fetchQuestion()
    }
    
    func addTextFieldPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: answerTextField.frame.height))
        answerTextField.leftView = paddingView
        answerTextField.leftViewMode = .always
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
        self.quizStatus = QuizStatus.RUNNING
        countdownTime = TimeUtil.QUIZ_LENGTH_TIME
        viewModel.userAnswers.removeAll()
        self.questionCountLabel.text = self.viewModel.getQuestionCount()
        answerTableView.reloadData()
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { closureTimer in
                self.timeCountdownLabel.text = TimeUtil.formatCountdownTime(timeInSecs: self.countdownTime)
                if self.countdownTime > 0 {
                    self.countdownTime -= 1
                } else {
                    self.timer.invalidate()
                    self.quizStatus = QuizStatus.FINISHED
                    self.presentQuizEndedAlert(success: false)
                }
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func onStartButtonPress(_ sender: UIButton) {
        sender.setTitle("Reset", for: .normal)
        restartQuiz()
    }
}

extension QuestionViewController : QuizQuestionVMFetchDelegate {
    func didFetchQuestion(question: Question) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
            self.questionLabel.text = question.question
            self.questionCountLabel.text = self.viewModel.getQuestionCount()
            self.quizStatus = QuizStatus.NOT_STARTED
        }
    }
    
    func didFail(error: Error?) {
        self.dismiss(animated: true, completion: nil)
        let alert = UIAlertController(title: "Oops", message: "Something went wrong.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reload", style: .default, handler: { _ in
            self.viewModel = QuizQuestionViewModel(questionNumber: 1)
            self.viewModel.delegate = self
            self.viewModel.fetchQuestion()
        }))
        self.present(alert, animated: true)
    }
    
    func didStartFetching() {
        performSegue(withIdentifier: "loadingSegue", sender: nil)
    }
    
}

extension QuestionViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else {
            return 0
        }
        return vm.userAnswers.count
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
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let currentText = textField.text ?? ""
        if viewModel.checkAnswer(currentText) {
            answerTextField.text = ""
            questionCountLabel.text = viewModel.getQuestionCount()
            answerTableView.reloadData()
            
            if viewModel.userAnswers.count == viewModel.question!.answer.count {
                timer.invalidate()
                self.quizStatus = QuizStatus.FINISHED
                presentQuizEndedAlert(success: true)
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if quizStatus == QuizStatus.NOT_STARTED {
            let alert = UIAlertController(title: "Not so fast!", message: "You need to start the quiz to begin answering", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
        }
        return true
    }
}
