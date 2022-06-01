//
//  ViewController.swift
//  faceLogin
//
//  Created by pothuri raju on 01/06/22.
//

//  code for Using face id 
// add privacy- face id in info.plist

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button  = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.center = view.center
        button.setTitle("Face Id Login", for: .normal)
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)
    }


    @objc func didTapButton(){
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: &error) {
            let reason = "Please authorize with touch id!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        
                        // failed
                        let alert = UIAlertController(title: "Failed to Authenticate",message: "Please try again.",preferredStyle:.alert)
                        alert.addAction(UIAlertAction(title: "Dismiss",
                                                      style:.cancel,
                                                      handler: nil))
                        self?.present(alert, animated: true)
                        return
                    }
                    // Show other screen
                    // Success
                    let vc = UIViewController()
                    vc.title = "Welcome"
                    vc.view.backgroundColor = .systemBlue
                    self?.present(UINavigationController(rootViewController: vc),animated: true,completion: nil)

                }
               
            }
        }
        else
        {
            
            let alert = UIAlertController(title: "Unavailable",
                                          message: "U can not use this fearure",
                                          preferredStyle:.alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style:.cancel,
                                          handler: nil))
            present(alert, animated: true)
            
        }
        
    }

}
