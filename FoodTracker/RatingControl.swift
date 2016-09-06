//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Ross Sabes on 8/26/16.
//  Copyright © 2016 Ross Sabes. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    
    var rating = 0 {
        didSet{
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5

    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledstar")
        let emptyStarImage = UIImage(named: "emptystar")
        
        
        for _ in 0..<starCount {
            let button = UIButton()
            button.setImage(emptyStarImage, for: .normal)
            button.setImage(filledStarImage, for: .selected)
            button.setImage(filledStarImage, for: [.highlighted, .selected])
            button.adjustsImageWhenHighlighted = false
            // button.backgroundColor = UIColor.red
            button.addTarget(self, action: #selector(self.ratingButtonTapped(_:)), for: .touchDown)
            ratingButtons += [button]
            addSubview(button)
        }
        
    }
    
    override func layoutSubviews() {
        
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
        
    }
    
    // MARK: Button Action
    
    func ratingButtonTapped(_ button: UIButton){
        rating = ratingButtons.index(of: button)! + 1
        updateButtonSelectionStates()
    }

    func updateButtonSelectionStates(){
        // If the index of a button is less than the rating, that button should be selected
        for(index, button) in ratingButtons.enumerated(){
            button.isSelected = index < rating
        }
    }

}
