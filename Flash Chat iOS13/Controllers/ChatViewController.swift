

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore()
    
    var messages: [Message] = [
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        title = Constant.Title
        navigationItem.hidesBackButton = true
        tableView.register(UINib.init(nibName: Constant.cellNibName, bundle: nil), forCellReuseIdentifier: Constant.cellIdentifier)
        loaddata()

    }
    func loaddata(){
       
        
        db.collection(Constant.FStore.collectionName).order(by: Constant.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            
            if let e = error {
                print("There is an error in loading data, \(e)")
            }
            else{
                if let snapshotdocuments = querySnapshot?.documents{
                    for doc in snapshotdocuments{
                        let data = doc.data()
                        if let messageSender = data[Constant.FStore.senderField] as? String, let messagebody = data[Constant.FStore.bodyField] as? String{
                            
                            let newmessage = Message(Sender: messageSender, Body: messagebody)
                            self.messages.append(newmessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let index = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: index, at: UITableView.ScrollPosition.top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if  let messagebody = messageTextfield.text,let messagesender = Auth.auth().currentUser?.email {
            db.collection(Constant.FStore.collectionName).addDocument(data: [Constant.FStore.senderField : messagesender, Constant.FStore.bodyField: messagebody,Constant.FStore.dateField : Date().timeIntervalSince1970 ]) { (error) in
                if let e = error{
                    print("Error saving Database  , \(e)")
                    
                }
                else {
                    print ("Successfully saved to DB ")
                    
                    DispatchQueue.main.async{
                        self.messageTextfield.text = ""
                    }
                    
                }
            }
        }
    }
    
    @IBAction func LogoutPressed(_ sender: Any) {
        
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
          
    }
    
}
extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath) as! MessageCell
        cell.Label.text = message.Body
        
        
        
        // Message from current user
        if message.Sender == Auth.auth().currentUser?.email{
            cell.leftimage.isHidden = true
            cell.rightimage.isHidden = false
            cell.messagebubble.backgroundColor = UIColor(named: Constant.BrandColors.lightPurple)
            cell.Label.textColor = UIColor(named:Constant.BrandColors.purple )
        }
        // mMessage from other use
        else {
        
            cell.leftimage.isHidden = false
            cell.rightimage.isHidden = true
            cell.messagebubble.backgroundColor = UIColor(named: Constant.BrandColors.newcolor)
            cell.Label.textColor = UIColor(named: Constant.BrandColors.lightPurple)
            
        }
      
        return cell
    }
}
