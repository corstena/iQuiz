//
//  QuestionScreenViewController.swift
//  iQuiz
//
//  Created by iGuest on 11/10/16.
//  Copyright © 2016 iSchool. All rights reserved.
//

import UIKit

class QuestionScreenViewController: UIViewController {
    
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    var answerSelected = false
    var jsonData = [quizSection]()
    var questionCategory = Int()
    var questionNumber = Int()
    var selectedAnswer = Int()
    var correctAnswer = Int()
    var questionText = String()
    var correctAnswerText = String()
    var totalCorrectAnswers : Int?
    
    @IBAction func selectedAnswer(_ sender: UIButton) {
        clearSelected()
        sender.backgroundColor = UIColor.green
        sender.setTitleColor(UIColor.black, for: UIControlState.normal)
        answerSelected = true
        setSelectedAnswer(sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerSelected = false
        for section in jsonData {
            if section.rowNumber == questionCategory {
                questionLabel.text = section.questions[questionNumber].questionText
                questionText = section.questions[questionNumber].questionText
                var answerList = section.questions[questionNumber].possibleAnswers
                option1.setTitle(answerList[0], for: UIControlState.normal)
                option2.setTitle(answerList[1], for: UIControlState.normal)
                option3.setTitle(answerList[2], for: UIControlState.normal)
                option4.setTitle(answerList[3], for: UIControlState.normal)
                correctAnswer = Int(section.questions[questionNumber].correctAnswer)!
                correctAnswerText = answerList[correctAnswer - 1]
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clearSelected() {
        option1.backgroundColor = UIColor.gray
        option2.backgroundColor = UIColor.gray
        option3.backgroundColor = UIColor.gray
        option4.backgroundColor = UIColor.gray
        option1.setTitleColor(UIColor.white, for: UIControlState.normal)
        option2.setTitleColor(UIColor.white, for: UIControlState.normal)
        option3.setTitleColor(UIColor.white, for: UIControlState.normal)
        option4.setTitleColor(UIColor.white, for: UIControlState.normal)
    }

    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        if(answerSelected) {
            performSegue(withIdentifier: "goToAnswer", sender: self)
        }
    }
    
    @IBAction func goBackToHome(_ sender: UIButton) {
         performSegue(withIdentifier: "questionToHome", sender: self)
    }
    
    func setSelectedAnswer(sender: UIButton) {
        if sender == option1 {
            selectedAnswer = 1
        } else if sender == option2 {
            selectedAnswer = 2
        } else if sender == option3 {
            selectedAnswer = 3
        } else {
            selectedAnswer = 4
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAnswer" {
            let answerScreenViewController = segue.destination as! AnswerSceenViewController
            answerScreenViewController.jsonData = jsonData
            answerScreenViewController.questionNumber = questionNumber
            answerScreenViewController.questionCategory = questionCategory
            answerScreenViewController.selectedAnswer = selectedAnswer
            answerScreenViewController.correctAnswer = correctAnswer
            answerScreenViewController.questionText = questionText
            answerScreenViewController.correctAnswerText = correctAnswerText
        } else if segue.identifier == "questionToHome" {
            let homeScreenViewController = segue.destination as! UINavigationController
        }
    }
}
