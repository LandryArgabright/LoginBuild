//
//  SignupViewController.swift
//  LoginBuild
//
//  Created by Ray Argabright on 6/18/20.
//  Copyright © 2020 Landry Argabright. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignupViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    
        // Gesture swipe right -- go to HomeViewController
        
        let returnSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        
        // Recognizes swipe right only
        returnSwipe.direction = UISwipeGestureRecognizer.Direction.right
        
        // Add gesture to view
        self.view.addGestureRecognizer(returnSwipe)
        
    }
    
    // MARK: Gesture Action
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        
        // Switch statement fires action
        switch swipe.direction.rawValue {
        case 1 :
            
            // Segue to Home View Controller
            performSegue(withIdentifier: "swipeBack", sender: self)
            
        default:
            
            // Nothing else
            print("Uh Oh")
            break
        }
        
    }
    
    // MARK: Set up View Controller Elements
    
    func setUpElements() {
        
        // hide error label
        errorLabel.alpha = 0
        
        
        // Textfield objects and set styling
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        
        // style Button
        Utilities.styleFilledButton(goButton)
        
        self.view.backgroundColor = UIColor(red: 243/255.0, green: 217/255.0, blue: 187/255.0, alpha: 1.0)
        
        
    }
    


// MARK: Validate Text Fields
    
    // Check fields and values -> method returns nil otherwise returns error message as string
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Complete Sign Up Fields!"
        }
        
        // Check for valid password
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            
            return "Password must be 8 characters long have 1 number and 1 special character"
        }
        
        return nil
    }
    
    // shows label error and unique message
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    
    // MARK: GO Button Action
    
    @IBAction func goButtonTapped(_ sender: Any) {
        
        
               // Validate the fields and create User
               let error = validateFields()
               
               if error != nil {
                   // Error show error message
                   showError(error!)
                   
               }
               else {
                   
                   // Create cleaned versions of the data
                   let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   var password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   
                    // MARK: Salt & Hash Password
                
                password = Utilities.hashPassword(password)
                    
                
                   // Create the User
                   Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                       // Check for errors
                       if err != nil {
                           
                           // Error
                           self.showError("Error Creating User")
                           
                       }
                       else {
               
                           
                           //User was created succesfully
                           // Store firstname last name email and password
                        // Database Connection
                           let db = Firestore.firestore()
                           
                           
                        //  ADD SALT PROPERTY TO BE ADDED
                        db.collection("users").addDocument(data: ["firstName":firstName, "lastName":lastName, "email":email, "password":password, "uid":result!.user.uid]) { (error) in
                               
                               
                               if error != nil {
                                   //Show error message
                                   
                                   self.showError("Error saving your data!")
                               }
                               
                               
                               
                               
                           }
                           
                           // Transition to home screen
                           self.transistionToHome()
                   }
                       
               }
               
               
               }

        
    }
    
    
    
    func transistionToHome() {
        
        let homeVCON = storyboard?.instantiateViewController(identifier: "HomeVC")
        
        view.window?.rootViewController = homeVCON
        view.window?.makeKeyAndVisible()
    }

}

