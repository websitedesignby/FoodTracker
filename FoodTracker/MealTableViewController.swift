//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Ross Sabes on 9/6/16.
//  Copyright © 2016 Ross Sabes. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var meals = [Meal]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedMeals = loadMeals() {
            meals += savedMeals
        }
        else{
            // Load the sample data
            loadSampleMeals()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadSampleMeals(){
        
        let photo1 = UIImage(named: "meal1")!
        let meal1 = Meal(name: "Chili", photo: photo1, rating: 4)!
        
        let photo2 = UIImage(named: "meal2")
        let meal2 = Meal(name: "Gyro", photo: photo2, rating: 5)!
        
        let photo3 = UIImage(named: "meal3")
        let meal3 = Meal(name: "Grilled Sandwich", photo: photo3, rating: 3)!
        
        meals += [meal1, meal2, meal3]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "MealTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealTableViewCell
        
        let meal = meals[indexPath.row]

        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }
    


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            // Save the meals.
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowDetail"{
            
            let mealDetailViewController = segue.destination as! MealViewController
            
            // Get the cell that generated the segue
            if let selectedMealCell = sender as? MealTableViewCell{
                let indexPath = tableView.indexPath(for: selectedMealCell)
                let selectedMeal = meals[indexPath!.row]
                mealDetailViewController.meal = selectedMeal
            }
        }
        
        else if segue.identifier == "AddItem"{
            print("Adding new meal.")
        }
        
    }
 
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue){
        
        // print("called unwindToMealList")
        print(sender.source)
        
        if let sourceViewController = sender.source as? MealViewController{
            // print("okay")
            if let meal = sourceViewController.meal{
                // save existing meal
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    print("saving existing")
                    print(meal.name)
                    print(selectedIndexPath.row)
                    meals[selectedIndexPath.row] = meal
                    // refresh the tableview
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
                else{
                    // print(meal) <FoodTracker.MealViewController: 0x141e2a2a0>
                    let newIndexPath = IndexPath(row: meals.count, section: 0)
                    meals.append(meal)
                    tableView.insertRows(at: [newIndexPath], with: .bottom)
                }
                // Save the meals.
                saveMeals()
            }
        }
        /*
        if let sourceViewController = sender.source as?
            MealViewController, let meal = sourceViewController.meal{
                print("add a new meal")
                // Add a new meal.
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
        }*/
    }
    
    // MARK: NSCoding
    
    func saveMeals(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        if !isSuccessfulSave{
            print("Failed to save meals...")
        }
    }
    
    func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }

}
