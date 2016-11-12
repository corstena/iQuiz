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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
