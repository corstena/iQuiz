//
//  AnswerSceenViewController.swift
//  iQuiz
//
//  Created by iGuest on 11/10/16.
//  Copyright © 2016 iSchool. All rights reserved.
//

import UIKit

class AnswerSceenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        //if all questions complete
        performSegue(withIdentifier: "goToResults", sender: self)
        //if not all questions complete go to next question
        // performSegue(withIdentifier: "goToNextQuestion", sender: self)
    }
    
    @IBAction func answerToHome(_ sender: AnyObject) {
        performSegue(withIdentifier: "answerToHome", sender: self)
    }
}
