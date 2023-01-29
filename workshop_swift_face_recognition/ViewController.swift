//
//  ViewController.swift
//  workshop_swift_face_recognition
//
//  Created by Levent Kantaroğlu on 29.01.2023.
//

import LocalAuthentication
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func displayResult(_ success: Bool?) {
        DispatchQueue.main.async {
            self.resultText.text = success != nil ? String(success!) : "Error"
        }
    }

    @IBAction func signInButton(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        self.resultText.text = ""
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            self.resultText.text = "..."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Giriş için teyit gerekli") { success, _ in
                self.displayResult(success)
            }
        } else if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            self.resultText.text = "..."
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Giriş için teyit gerekli") { success, _ in
                self.displayResult(success)
            }
        } else {
            self.displayResult(nil)
        }
    }

    @IBOutlet var resultText: UILabel!
}
