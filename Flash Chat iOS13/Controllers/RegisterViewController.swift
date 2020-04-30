

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var ErrorMessage: UILabel!
    override func viewDidLoad() {
              super.viewDidLoad()
        title = Constant.Title
          }
    
    @IBAction func registerPressed(_ sender: UIButton)
    {
        if let email = emailTextfield.text,let password = passwordTextfield.text{
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
                let x=e.localizedDescription
                self.ErrorMessage.text = "⚠️" + "\n" + x
                
            }
            else {
                self.performSegue(withIdentifier: Constant.registerSegue, sender: self)
                }
            }
            
        }
    }
}
