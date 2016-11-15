//
//  iQuizTableViewController.swift
//  iQuiz
//
//  Created by iGuest on 11/4/16.
//  Copyright © 2016 iSchool. All rights reserved.
//

import UIKit

class iQuizTableViewController: UITableViewController {
    
    var questionCategories = ["Mathematics", "Marvel Super Heroes", "Science"]
    var categoryDescriptions = ["Questions realted to math. Duh.", "Everything about Marvel Super Heroes.", "SCIIIIIENCCE!"]
    var imageList = ["math", "marvel", "chemistry"]

    override func viewDidLoad() {
        super.viewDidLoad()
        //process JSON file
        let requestURL: NSURL = NSURL(string: "http://tednewardsandbox.site44.com/questions.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                NSLog("File downloaded successfully.")
                do{
                    
                    let quizJson = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String:Any]
                    
                    if let categories = quizJson["categories"] as? [[String: Any]] {
                        for category in categories {
                            if let title = category["title"] as? String {
                               self.questionCategories.append(title)
                                if let description = category["desc"] as? String {
                                    self.categoryDescriptions.append(description)
                                    if let questions = category["questions"] as? [[String: Any]] {
                                        for question in questions {
                                            if let text = question["text"] as? String {
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    
//                    if let categories = quizJson["stations"] as? [[String: AnyObject]] {
//                        
//                        for station in stations {
//                            
//                            if let name = station["stationName"] as? String {
//                                
//                                if let year = station["buildYear"] as? String {
//                                    print(name,year)
//                                }
//                                
//                            }
//                        }
//                        
//                    }
//                    
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
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
        performSegue(withIdentifier: "goToQuestion", sender: self)
    }

}
