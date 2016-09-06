//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Ross Sabes on 8/25/16.
//  Copyright © 2016 Ross Sabes. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `MealTableViewController` in 
       `prepareForSeque(_:sender:)`
        or constructed as part of adding a new meal
    */
    var meal: Meal?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handle the text field's user input through delegate callbacks.
        nameTextField.delegate = self
    }

    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        // !!! Error 2016-08-25 21:35:53.182476 FoodTracker[3263:595451] [Generic] Creating an image format with an unknown type is an error
        
        // The info dictionary contains multiple representations of the image, and this uses the original
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedImage
        
        // print(info)
        /*
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            // Set photoImageView to display the selected image.
            photoImageView.image = selectedImage
        } else{
            print("Something went wrong")
        }
         */
        
        // Dismiss the picker.
         dismiss(animated: true, completion: nil)
    }
    
    // MARK: Navigation
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if saveButton === sender as! UIBarButtonItem{
            print("saveButton was the sender.")
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            // Set the meal to be passed to MealTableViewController after the unwind seque
            meal = Meal(name: name, photo: photo, rating: rating)
        }else{
            print("saveButton was NOT the sender.")
            print(sender)
        }

        
    }
    
    // MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
        
    }

    

}

