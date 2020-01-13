//
//  LoadingQuestionViewController.swift
//  wordQuiz
//
//  Created by Leonardo Thives da Luz Fontes on 1/12/20.
//  Copyright © 2020 Leo Fontes. All rights reserved.
//

import UIKit

class LoadingQuestionViewController: UIViewController {
    @IBOutlet weak var dialogView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dialogView.layer.cornerRadius = 16.0
    }
}
