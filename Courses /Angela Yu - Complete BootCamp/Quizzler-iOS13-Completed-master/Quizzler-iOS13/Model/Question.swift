//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 07/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    let text: String
    let answer: String
    
    
    /*
     init could make an initialization for a struct without any inherited values of its variables.
     So you could make various object with the same type of object that is defined by a struct, and not making any new struct.
     
     Once you make the object by making variable using this struct, you would be asked to input the 'characteristics' of the object.
     */
    init(q: String, a: String) {
        
        /*
         The variables here could be made the same as the variable above, but it would be confusing.
         */
        text = q
        answer = a
    }
}

    
