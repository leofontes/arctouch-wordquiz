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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        answerTextField.delegate = self
        answerTableView.dataSource = self
        answerTableView.delegate = self
        
        viewModel = QuizQuestionViewModel(questionNumber: 1, delegate: self)
    }

    @IBAction func onStartButtonPress(_ sender: Any) {
        
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
        //TODO inform user of failure
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
            answerTableView.reloadData()
        }
    }
}
