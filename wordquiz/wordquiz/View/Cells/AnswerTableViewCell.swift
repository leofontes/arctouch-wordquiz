//
//  AnswerTableViewCell.swift
//  wordQuiz
//
//  Created by Leonardo Fontes on 1/11/20.
//  Copyright © 2020 Leo Fontes. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet var answerLabel: UILabel!
    
    func configure(answer: String) {
        answerLabel.text = answer
    }
}
