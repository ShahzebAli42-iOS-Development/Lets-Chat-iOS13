//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Shahzeb on 10/04/2020.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messagebubble: UIView!
    @IBOutlet weak var Label: UILabel!

    @IBOutlet weak var rightimage: UIImageView!
    @IBOutlet weak var leftimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messagebubble.layer.cornerRadius = messagebubble.frame.size.height / 5
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
