

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
 
    @IBOutlet weak var LoginErrorMessage: UILabel!
    
    override func viewDidLoad() {
           super.viewDidLoad()
        title = Constant.Title
       }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        
        if let email = emailTextfield.text,let password = passwordTextfield.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
                let x=e.localizedDescription
                self.LoginErrorMessage.text = "\n⚠️" + "\n" + x
            }
            else {
                self.performSegue(withIdentifier: Constant.loginSegue , sender: self)
                }
            }
            
        }
    }
    
}
