//
//  SignupViewController.swift
//  LoginBuild
//
//  Created by Ray Argabright on 6/18/20.
//  Copyright © 2020 Landry Argabright. All rights reserved.
//

import UIKit

class SignupViewController: ViewController {

    
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
    
    override func setUpElements() {
        
        // hide error label
        errorLabel.alpha = 0
        
        
        // loop through textfield objects and set styling
        for tf in [firstNameTextField, lastNameTextField, emailTextField, passwordTextField] {
            Utilities.styleTextField(tf!)
        }
        
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

    
    @IBAction func goTapped(_ sender: Any) {
        
        
    }
    
    
}
