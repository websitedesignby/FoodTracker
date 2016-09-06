//
//  Meal.swift
//  FoodTracker
//
//  Created by Ross Sabes on 8/28/16.
//  Copyright © 2016 Ross Sabes. All rights reserved.
//

import UIKit

class Meal{
    
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initialization
    
    init?(name: String, photo:UIImage?, rating: Int){
        
        self.name = name
        self.photo = photo
        self.rating = rating
        
        if( name.isEmpty || rating < 0 ){
            return nil
        }
        
    }
    
}
