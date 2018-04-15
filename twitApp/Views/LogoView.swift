//
//  LogoView.swift
//  twitApp
//
//  Created by Dayana Marden on 15.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

class LogoView: UIView {
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.text = "ZHOAPP"
        label.textColor = UIColor(displayP3Red: 94/255, green: 87/255, blue: 171/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 36)
        label.frame = CGRect(x: self.center.x, y: self.center.y, width: 200, height: 36)
        return label
    }()
    lazy var subname: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 16)
        label.frame = CGRect(x: self.center.x, y: self.name.frame.minY , width: 200, height: 100)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(name)
        self.addSubview(subname)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

}
