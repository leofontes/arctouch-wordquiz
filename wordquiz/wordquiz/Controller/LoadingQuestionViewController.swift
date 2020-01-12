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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
