//
//  iQuizTableViewController.swift
//  iQuiz
//
//  Created by iGuest on 11/4/16.
//  Copyright © 2016 iSchool. All rights reserved.
//

import UIKit

class iQuizTableViewController: UITableViewController {
    
    var questionCategories = [String]()
    var categoryDescriptions = [String]()
    var imageList = ["chemistry", "marvel", "math"]
    var quizJson = [[String:Any]]()
    var questionCategory = Int()
    var jsonData = [quizSection]()
    var questionNumber = 0
    var totalCorrectAnswers = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson()
        //process JSON file
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return questionCategories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iQuizCell", for: indexPath) as! iQuizTableViewCell
        cell.questionLabel.text = questionCategories[indexPath.row]
        cell.descriptionLabel.text = categoryDescriptions[indexPath.row]
        cell.categoryImage.image = UIImage(named : imageList[indexPath.row])
        // Configure the cell...

        return cell
    }

    @IBAction func settingsAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: "Settings go here", message: "Yay settings!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! iQuizTableViewCell
        questionCategory = indexPath.row
        performSegue(withIdentifier: "goToQuestion", sender: self)
    }
    
    func loadJson() {
        let requestURL: NSURL = NSURL(string: "https://tednewardsandbox.site44.com/questions.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                NSLog("File downloaded successfully.")
                do{
                    
                    let quizJson = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
                    
                    for i in 0 ..< quizJson.count {
                        let newQuizSection = quizSection()
                        newQuizSection.rowNumber = i
                        if let title = quizJson[i]["title"] as? String {
                            self.questionCategories.append(title)
                            newQuizSection.categoryName = title
                        }
                        if let description = quizJson[i]["desc"] as? String {
                            self.categoryDescriptions.append(description)
                            newQuizSection.categoryDescriptom = description
                        }
                        let questionText = quizJson[i]["questions"] as? [[String: Any]]
                        for question in questionText! {
                            let newQuestion = Question()
                            if let text = question["text"] as? String {
                                newQuestion.questionText = text
                            }
                            if let correctAnswer = question["answer"] as? String {
                                newQuestion.correctAnswer = correctAnswer
                            }
                            if let answers = question["answers"] as? [String] {
                                for answer in answers {
                                    newQuestion.possibleAnswers.append(answer)
                                }
                            }
                            newQuizSection.questions.append(newQuestion)
                        }
                        self.jsonData.append(newQuizSection)
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let questionScreenViewController = segue.destination as! QuestionScreenViewController
        questionScreenViewController.jsonData = jsonData
        questionScreenViewController.questionNumber = questionNumber
        questionScreenViewController.questionCategory = questionCategory
        questionScreenViewController.totalCorrectAnswers = totalCorrectAnswers
    }

}
