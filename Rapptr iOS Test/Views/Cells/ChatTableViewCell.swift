//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

enum ImageError: Error {
    case couldNotDecode
}

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     **/
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var bubble: UIView!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bubble.layer.cornerRadius = 8
        bubble.layer.borderColor = UIColor.init(named: "Border Color")?.cgColor
        bubble.layer.borderWidth = 1
    }
    
    // MARK: - Public
    func setCellData(message: Message) {
        header.text = message.name
        body.text = message.message
        if let url = message.avatarURL{
            getAvatar(for: url)
        }
    }
    
    func getAvatar(for url: URL) -> Void {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                return
            }

            guard let decodedImage = UIImage(data: data!) else {
                return
            }
            DispatchQueue.main.async {
                self.avatar.image = decodedImage
                self.avatar.setCircle()
            }

        }.resume()
    }
}

extension UIImageView {

   func setCircle() {
       let radius = self.frame.width / 2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
   }
}
