//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    // MARK: - Properties
    private var client: LoginClient?
    
    @IBOutlet weak var emailTextField: UITextField! { didSet { emailTextField.delegate = self } }
    @IBOutlet weak var passwordTextField: UITextField! { didSet { passwordTextField.delegate = self } }
    @IBOutlet weak var loginButton: CustomButton!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        
        loginButton.cornerRadius = 8
        
        self.navigationController?.navigationBar.topItem?.title = " "
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white,
                                                            .font : UIFont.systemFont(ofSize: 17.0, weight: .semibold)]
        
        var attriString = NSAttributedString(string:"Email", attributes:
                                                [NSAttributedString.Key.foregroundColor: UIColor.init(named: "Placeholder Text") ?? UIColor.lightText,
                                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        
        self.hideKeyboardWhenTappedAround()

        emailTextField.layer.cornerRadius = 8
        emailTextField.setLeftPaddingPoints(24)
        emailTextField.attributedPlaceholder = attriString
        
        attriString = NSAttributedString(string:"Password", attributes:
                                                [NSAttributedString.Key.foregroundColor: UIColor.init(named: "Placeholder Text") ?? UIColor.lightText,
                                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.setLeftPaddingPoints(24)
        passwordTextField.attributedPlaceholder = attriString

        client = LoginClient()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeLoginErrorAlert(error: String){
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Login Error", message: error, preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default)

            ac.addAction(okAction)
            self.present(ac, animated: true)
        }
    }
    
    func makeLoginSuccessAlert(message: String){
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Login Success", message: message, preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default){ [weak self] action in
                let mainMenuViewController = MenuViewController()
                self?.navigationController?.pushViewController(mainMenuViewController, animated: true)
            }

            ac.addAction(okAction)
            self.present(ac, animated: true)
        }
    }
    
    // MARK: - Actions
    @IBAction func didPressLoginButton(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        let start = Date.timeIntervalSinceReferenceDate

        client?.login(email: email, password: password, completion: { [self](string) in
            let end = Date.timeIntervalSinceReferenceDate
            let secondsElapsed = end - start
            print(secondsElapsed)
            print(string)
            makeLoginSuccessAlert(message: "\(string) \(secondsElapsed)")
        }, error: { [self](string) in
            let end = Date.timeIntervalSinceReferenceDate
            let secondsElapsed = end - start
            print(secondsElapsed)
            if let error = string {
                print(error)
                makeLoginErrorAlert(error: error)
            }
        })
    }
}

// MARK: Text Feild Delegate functions
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
#if DEBUG
        if textField == self.emailTextField {
            textField.text = "info@rapptrlabs.com"
        } else if textField == self.passwordTextField {
            textField.text = "Test123"
        }
#endif
    }
        
    // This function is called when you click return key in the text field.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        NSLog("textFieldShouldReturn")
        textField.resignFirstResponder();

        return true
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
