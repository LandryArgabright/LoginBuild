//
//  ViewController.swift
//  LoginBuild
//
//  Created by Ray Argabright on 6/18/20.
//  Copyright © 2020 Landry Argabright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setUpElements()
    }

    
     func setUpElements() {
        
        // Set button styles
        Utilities.styleFilledButton(signupButton)
        Utilities.styleHollowButton(loginButton)
        
    }

}

