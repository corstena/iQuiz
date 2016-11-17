//
//  quizSection.swift
//  iQuiz
//
//  Created by iGuest on 11/16/16.
//  Copyright © 2016 iSchool. All rights reserved.
//

import UIKit

class quizSection: NSObject {
    var categoryName = " "
    var categoryDescriptom = " "
    var rowNumber = Int()
    var questions = [Question]()
}

class Question: NSObject {
    var questionText = " "
    var correctAnswer = " "
    var possibleAnswers = [String]()
}
