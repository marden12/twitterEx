//
//  PostsTableViewCell.swift
//  twitApp
//
//  Created by Dayana Marden on 15.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
class PostsTableViewCell: UITableViewCell {
    lazy var user_name: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textColor = UIColor(displayP3Red: 94/255, green: 87/255, blue: 171/255, alpha: 1)
        label.frame = CGRect(x: 5, y: 5, width: 150, height: 20)
        return label
    }()
    lazy var current_time: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.frame = CGRect(x: self.frame.maxX - 16, y: self.frame.midY, width: 100, height: 20)
        label.textColor = UIColor(displayP3Red: 94/255, green: 87/255, blue: 171/255, alpha: 1)
        return label
    }()
    lazy var comment_text: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.frame = CGRect(x: 5, y: self.user_name.frame.maxY , width: self.frame.width, height: self.frame.height)
        label.numberOfLines = 100
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        [user_name,current_time,comment_text].forEach{
            self.addSubview($0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented coder")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
