//
//  Utilities.swift
//
//
// Created by Landry Aragbright

import Foundation
import UIKit
import CommonCrypto

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
    // Hashes password with SHA-512 & will add salting
    static func hashPassword(_ password : String) -> String {
         
        /* TODO: Salting
        let chars = "abcdefghijklmnopqrstuvwxyzZYXWVUTSRQPONMLKJIHGFEDCBA9876543210"
        let saltLength = 8
        var randomSalt = ""
        
         var saltChars = (0..<saltLength.map{_ in chars.randomElement()! }
         for ch in saltChars {
            randomSalt.append(ch
         }
         
         print (randomSalt + str)
         
         */
        
        // Hashing begins
        if let strData = password.data(using: String.Encoding.utf8) {
            
            // array of unsigned 8 bit integers of 32 length
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
            
            // CC_SHA_512 - digest calculation
            strData.withUnsafeBytes {
                
                CC_SHA512($0.baseAddress, UInt32(strData.count), &digest)
            }
            
            
            // Unpack SHA512
            var sha512String = ""
            
            // Unpack each byte in the digest array and add to sha512String
            for byte in digest {
                sha512String += String(format: "%02x", UInt8(byte))
            }
            
            // Correct hash check
            //if sha512String == "ef81cd41fbc4316dddca25172cd30379aa3ab73ee30ac5db1ef55cd3f638451f755a1cc9b92773fcfcc6c5ff9e38d1e9ba701080f0be28b7191e7463b828e8a6" {
                
                
                //print("Mater Dei: Correct")
                
                
                //} else {
                
                    //print(" SHA-512 does not match")
                
                //}
            
                return sha512String
            
            }
        
        return "Does not mach"
    }
    
}
