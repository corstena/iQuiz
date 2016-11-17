//
//  ResultsScreenViewController.swift
//  iQuiz
//
//  Created by iGuest on 11/10/16.
//  Copyright © 2016 iSchool. All rights reserved.
//

import UIKit

class ResultsScreenViewController: UIViewController {
    
    var totalCorrectAnswers = Int()
    var totalNumberOfQuestions = Int()

    @IBOutlet weak var quizScoreLabel: UILabel!
    @IBOutlet weak var quizDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizScoreLabel.text = "\(totalCorrectAnswers) / \(totalNumberOfQuestions)"
        if totalCorrectAnswers == totalNumberOfQuestions {
            quizDescriptionLabel.text = "AWESOME JOB! PERFECT SCORE!"
        } else if totalCorrectAnswers > 0 && totalCorrectAnswers < totalNumberOfQuestions {
            quizDescriptionLabel.text = "GOOD EFFORT!"
        } else {
            quizDescriptionLabel.text = "OUCH. THAT WAS A BAD TRY."
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resultsToHome(_ sender: AnyObject) {
        performSegue(withIdentifier: "resultsToHome", sender: self)
    }
}
