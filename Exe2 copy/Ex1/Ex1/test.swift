//
//  test.swift
//  Ex1
//
//  Created by Ashot Harutyunyan on 2024-03-06.
//

import UIKit

class ViewController: UIViewController {
    // Assume IBOutlet connections from storyboard
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
    }

    @IBAction func sayHelloWithLabel(_ sender: UIButton) {
        let name = nameTextField.text ?? ""
        welcomeLabel.text = "Hello, \(name)!"
    }

    @IBAction func sayHelloWithVC(_ sender: UIButton) {
        let name = nameTextField.text ?? ""
        // Assuming there's a view controller named GreetingViewController in your storyboard
        let greetingVC = self.storyboard?.instantiateViewController(withIdentifier: "GreetingViewController") as! GreetingViewController
        greetingVC.greetingMessage = "Hello, \(name)!"
        self.present(greetingVC, animated: true, completion: nil)
    }

    @IBAction func sayHelloWithAlert(_ sender: UIButton) {
        let name = nameTextField.text ?? ""
        let alert = UIAlertController(title: "Greeting", message: "Hello, \(name)!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// Assume another class for separate view controller
class GreetingViewController: UIViewController {
    var greetingMessage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Here you would set your greeting message to a label or other UI elements
    }
}

