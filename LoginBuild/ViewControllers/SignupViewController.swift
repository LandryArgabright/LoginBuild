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
    
    }
    
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
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
                   let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   
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
                           let db = Firestore.firestore()
                           
                           
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
