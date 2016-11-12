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

    @IBAction func selectedAnswer(_ sender: UIButton) {
        clearSelected()
        sender.backgroundColor = UIColor.green
        sender.setTitleColor(UIColor.black, for: UIControlState.normal)
        answerSelected = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerSelected = false
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
    
    @IBAction func nextButton(_ sender: UIButton) {
        if(answerSelected) {
            performSegue(withIdentifier: "goToAnswer", sender: self)
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

}
