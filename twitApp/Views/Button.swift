//
//  Button.swift
//  twitApp
//
//  Created by Dayana Marden on 15.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(displayP3Red: 94/255, green: 87/255, blue: 171/255, alpha: 1)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 10
        self.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
