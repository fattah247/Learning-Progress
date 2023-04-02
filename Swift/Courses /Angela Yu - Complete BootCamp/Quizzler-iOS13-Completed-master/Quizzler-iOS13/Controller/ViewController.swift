//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //This variable would use Struct (or our own data type), so the properties of it can be used.
    
    //Whenever you make a struct variable, make sure it's variable and not "let" or constant, so the properties inside can be accessed.
    var quizBrain = QuizBrain()
    
    /*
     So the Struct that has been made on the model can be used in any controller as much as we want, but we have to make the variable that can be used first
     */
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        
        let userGotItRight = quizBrain.checkAnswer(userAnswer: userAnswer)
        
        if userGotItRight {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        quizBrain.nextQuestion()
        
        
        /*
         This timer would clear the background color of the button after 0.2 seconds.
         
         This code will ensure that Green or Red Color will appear for 0.2 seconds.
         If this updateUI() is called directly, the Green and Red Color will not be apparent.
         */
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    
    //This function would allow the UI be updated whenever the Function is called, one of which is on the viewDidLoad()
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgress()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
    }

}


























