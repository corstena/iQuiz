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
    let defaults = UserDefaults.standard
    
    
    struct defaultsKeys {
        static let connectionURL = "URL"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
        var newURL = String()
        let alert = UIAlertController(title: "Enter new JSON URL", message: "Please enter valid URL", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "https://tednewardsandbox.site44.com/questions.json"
            newURL = textField.text!
        }
        self.defaults.setValue(newURL, forKey: defaultsKeys.connectionURL)
        self.defaults.synchronize()
        alert.addAction(UIAlertAction(title: "Set URL", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! iQuizTableViewCell
        questionCategory = indexPath.row
        performSegue(withIdentifier: "goToQuestion", sender: self)
    }
    
    func loadJson() {
        if defaults.string(forKey: defaultsKeys.connectionURL) == nil {
            self.defaults.setValue("https://tednewardsandbox.site44.com/questions.json", forKey: defaultsKeys.connectionURL)
            self.defaults.synchronize()
        }
        //RUN THIS CODE IF A BAD URL IS INPUT AND APP CRASHES
        //self.defaults.setValue("https://tednewardsandbox.site44.com/questions.json", forKey: defaultsKeys.connectionURL)
        //self.defaults.synchronize()
        if defaults.string(forKey: defaultsKeys.connectionURL)! != nil {
            NSLog("Connection URL: " + defaults.string(forKey: defaultsKeys.connectionURL)!)
        }
        let requestURL: NSURL = NSURL(string: defaults.string(forKey: defaultsKeys.connectionURL)!)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            let path = Bundle.main.path(forResource: "datafile", ofType: "txt")!
            var quizJson = [[String:Any]]()
            
            if (statusCode == 200) {
                NSLog("File downloaded successfully.")
                do{
                    quizJson = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
                    NSData(data: data!).write(toFile: path, atomically: true)
                    
                                    } catch {
                    print("Error with Json: \(error)")
                }
            } else { //load local data
                do {
                    var content = NSData(contentsOfFile: path)
                    quizJson = try JSONSerialization.jsonObject(with: content! as Data, options: []) as! [[String:Any]]
                } catch {
                    print("Error with Json: \(error)")
                }
                
            }
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

        }
        task.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let questionScreenViewController = segue.destination as! QuestionScreenViewController
        questionScreenViewController.jsonData = jsonData
        questionScreenViewController.questionNumber = 0
        questionScreenViewController.questionCategory = questionCategory
        questionScreenViewController.totalCorrectAnswers = 0
    }

}
