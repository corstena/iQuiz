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
    var answerSelected = false
    var quizJsonData = [[String:Any]]()
    var questionCategory = Int()
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBAction func selectedAnswer(_ sender: UIButton) {
        clearSelected()
        sender.backgroundColor = UIColor.green
        sender.setTitleColor(UIColor.black, for: UIControlState.normal)
        answerSelected = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerSelected = false
        NSLog("JSON COUNT SIZE:" + String(quizJsonData.count))
        for i in 0 ..< quizJsonData.count {
            if i == questionCategory {
                let questionText = quizJsonData[i]["questions"] as? [[String: Any]]
                for question in questionText! {
                    if let text = question["text"] as? String {
                        questionLabel.text = text
                    }
                    if let answers = question["answers"] as? [String] {
                        option1.setTitle(answers[0], for: UIControlState.normal)
                        option2.setTitle(answers[1], for: UIControlState.normal)
                        option3.setTitle(answers[2], for: UIControlState.normal)
                        option4.setTitle(answers[3], for: UIControlState.normal)
                    }
                }
            }
        }
        // Do any additional setup after loading the view.
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
