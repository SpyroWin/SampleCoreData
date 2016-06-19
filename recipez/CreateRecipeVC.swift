//
//  CreateRecipeVC.swift
//  recipez
//
//  Created by spyrowin on 6/19/16.
//  Copyright © 2016 htainmyoaung. All rights reserved.
//

import UIKit
import CoreData

class CreateRecipeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipeIngredients: UITextField!
    @IBOutlet weak var recipeSteps: UITextField!
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var addRecipeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeImg.layer.cornerRadius = 5.0
        recipeImg.clipsToBounds = true
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }

    @IBAction func addImagePressed(sender: UIButton!) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        recipeImg.image = image
    }
    
    @IBAction func createRecipe(sender: AnyObject){
        if let title = recipeTitle.text where title != "" {
            
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: context)!
            let recipe = Recipe(entity: entity, insertIntoManagedObjectContext: context)
            recipe.title = title
            recipe.ingredients = recipeIngredients.text
            recipe.steps = recipeSteps.text
            if let img = recipeImg.image {
                recipe.setRecipeImage(img)
            }
            
            context.insertObject(recipe)
            
            do {
                try context.save()
            }catch {
                print("Could not save recipe")
            }
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
}
