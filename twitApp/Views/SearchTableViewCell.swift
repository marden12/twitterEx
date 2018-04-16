//
//  SearchTableViewCell.swift
//  SearchBar
//
//  Created by Бекболат Куанышев on 16.04.2018.
//  Copyright © 2018 Bekbolat. All rights reserved.
//

import Foundation
import UIKit

class SearchTableViewCell: UITableViewCell {
    
    let hashtagLabel = UILabel()
    let emailLabel = UILabel()
    let dateLabel = UILabel()
    let textsLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(hashtagLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(textsLabel)
        
        contentView.backgroundColor = .clear

        hashtagLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        emailLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        dateLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        textsLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        
        hashtagLabel.textColor = .gray
        emailLabel.textColor = UIColor(displayP3Red: 94/255, green: 87/255, blue: 171/255, alpha: 1)
        
        hashtagLabel.textAlignment = .left
        hashtagLabel.backgroundColor = .clear
        emailLabel.textAlignment = .left
        emailLabel.backgroundColor = .clear
        dateLabel.textAlignment = .right
        dateLabel.backgroundColor = .clear
        textsLabel.textAlignment = .left
        textsLabel.backgroundColor = .clear
        textsLabel.numberOfLines = 4
        
        hashtagLabel.frame = CGRect(x: self.frame.minX + 5, y: self.frame.minY+8 , width: self.frame.width, height: 14)
        emailLabel.frame = CGRect(x: self.frame.minX + 5, y: self.hashtagLabel.frame.maxY+8, width: self.frame.width, height: 20)
        dateLabel.frame = CGRect(x: self.hashtagLabel.frame.maxX + 4, y: self.frame.minY+8, width: self.frame.width, height: 20)
        textsLabel.frame = CGRect(x: self.frame.minX + 5, y: self.emailLabel.frame.maxY+8, width: self.frame.width, height: 20)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
