//
//  File.swift
//  Affirmation
//
//  Created by Drew Westcott on 16/04/2016.
//  Copyright © 2016 Drew Westcott. All rights reserved.
//

import Foundation
import UIKit

class Affirmation: NSObject {
    private var _day: Int!
    private var _centeringThought: String!
    private var _mantra: String!
    private var _mantraMeaning: String!
    
    var day: Int {
        return _day
    }
    
    var centeringThought: String {
        return _centeringThought
    }
    
    var mantra: String {
        return _mantra
    }
    
    var mantraMeaning: String {
        return _mantraMeaning
    }
    
    init(day: Int, centeringThought: String, mantra: String, mantraMeaning: String) {
        self._day = day
        self._centeringThought = centeringThought
        self._mantra = mantra
        self._mantraMeaning = mantraMeaning
    }
    
}