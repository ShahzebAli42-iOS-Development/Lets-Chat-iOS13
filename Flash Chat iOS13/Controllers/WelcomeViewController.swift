

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    @IBOutlet weak var regbutton: UIButton!
    @IBOutlet weak var logbutton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        titleLabel.text = Constant.Title
        regbutton.layer.cornerRadius = regbutton.frame.height / 2
        logbutton.layer.cornerRadius = logbutton.frame.height / 2
        
        //MY Animation generation without using third party Api
        //var countindex = 0.0
        //titleLabel.text = ""
        //let titletext = "⚡️FlashChat"
        //for character in titletext{
          //  Timer.scheduledTimer(withTimeInterval: 0.1 * countindex, repeats: false) { (timer) in
            //    self.titleLabel.text?.append(character)
                
            //}
            //countindex +=  1
            
        //}
       
    }
    
}
