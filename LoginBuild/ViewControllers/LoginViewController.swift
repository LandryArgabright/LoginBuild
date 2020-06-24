//
//  LoginViewController.swift
//  LoginBuild
//
//  Created by Ray Argabright on 6/18/20.
//  Copyright © 2020 Landry Argabright. All rights reserved.
//


import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    
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
    
    
    // MARK: GESTURE
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        
        // Switch statement fires action
        switch swipe.direction.rawValue {
        case 1 :
            
            // Segue to Home View Controller
            performSegue(withIdentifier: "swipeBack2", sender: self)
            
        default:
            
            // Nothing else
            print("Uh Oh")
            break
        }
        
    }
    
    // MARK: View Controller Elements
    
    
    func setUpElements() {
        
        // Hide error label
        errorLabel.alpha = 0
        
        // Style text field items
        for tf in [emailTextField, passwordTextField] {
            
            Utilities.styleTextField(tf!)
        }
        
        // Style filled button
        Utilities.styleFilledButton(goButton)
        
        self.view.backgroundColor = UIColor(red: 243/255.0, green: 217/255.0, blue: 187/255.0, alpha: 1.0)
    }
    
    
    // MARK: Go Button Action

    @IBAction func goTapped(_ sender: Any) {
        
        // TODO: Validate Texts Fields
        // Validate the text field
        
        
        // Create cleaned version of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Checking hashing
        let hashPassword = Utilities.hashPassword(password)
        
        
        // Signing in the User
        Auth.auth().signIn(withEmail: email, password: hashPassword) { (result, error) in
            
            if error != nil {
                
                
                // Could not sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
                
            }
            else {
                
                
                let homeVCON = self.storyboard?.instantiateViewController(identifier: "HomeVC")
                
                self.view.window?.rootViewController = homeVCON
                self.view.window?.makeKeyAndVisible()
            }
            
            
        }
        
    }
    
    
    
}
