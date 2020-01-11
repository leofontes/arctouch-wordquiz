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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionLabel.text = "teste"
    }

}

extension QuestionViewController : QuizQuestionVMFetchDelegate {
    func didFetchQuestion(question: Question) {
        
    }
    
    func didFailWithError(error: Error) {
    
    }
    
    func didFail() {
        
    }
    
    
}

