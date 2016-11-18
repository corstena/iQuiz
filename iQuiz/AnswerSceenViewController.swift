//
//  AnswerSceenViewController.swift
//  iQuiz
//
//  Created by iGuest on 11/10/16.
//  Copyright © 2016 iSchool. All rights reserved.
//

import UIKit

class AnswerSceenViewController: UIViewController {
    
    var correctAnswer = Int()
    var selectedAnswer = Int()
    var jsonData = [quizSection]()
    var questionNumber = Int()
    var questionCategory = Int()
    var questionText = String()
    var correctAnswerText = String()
    var totalCorrectAnswers = Int()
    var totalNumberOfQuestions = Int()

    @IBOutlet weak var questionStatus: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedAnswer == correctAnswer {
            questionStatus.text = "CORRECT!"
            questionStatus.textColor = UIColor.green
            totalCorrectAnswers += 1
        } else {
            questionStatus.text = "INCORRECT!"
            questionStatus.textColor = UIColor.red
        }
        totalNumberOfQuestions = jsonData[questionCategory].questions.count
        question.text = questionText
        answer.text = "Answer: " + correctAnswerText
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func goToQuestionOrResult(_ sender: AnyObject) {
        if questionNumber + 1 < totalNumberOfQuestions {
            performSegue(withIdentifier: "goToNextQuestion", sender: self)
        } else {
            performSegue(withIdentifier: "goToResults", sender: self)
        }
    }
    
    @IBAction func answerToHome(_ sender: AnyObject) {
        performSegue(withIdentifier: "answerToHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNextQuestion" {
            let questionScreenViewController = segue.destination as! QuestionScreenViewController
            questionScreenViewController.jsonData = jsonData
            questionScreenViewController.questionNumber = questionNumber + 1
            questionScreenViewController.questionCategory = questionCategory
            questionScreenViewController.totalCorrectAnswers = totalCorrectAnswers
        } else if segue.identifier == "goToResults" {
            let resultsScreenViewController = segue.destination as! ResultsScreenViewController
            resultsScreenViewController.totalCorrectAnswers = totalCorrectAnswers
            resultsScreenViewController.totalNumberOfQuestions = totalNumberOfQuestions
        } else if segue.identifier == "answerToHome" {
            let homeScreenViewController = segue.destination as! UINavigationController
        }
    }
}
