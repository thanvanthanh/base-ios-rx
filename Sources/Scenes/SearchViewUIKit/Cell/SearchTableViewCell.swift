//
//  SearchTableViewCell.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
    }
    
    func config(data: SearchModel?) {
        guard let data = data else { return }
        nameLabel.text = data.login
        avatarImage.sd_setImage(with: URL(string: data.avatarUrl))
    }
    
}
