//
//  TextField.swift
//  twitApp
//
//  Created by Dayana Marden on 15.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor(displayP3Red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(displayP3Red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
class TextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setBottomBorder()
        self.backgroundColor = UIColor(displayP3Red: 212/255, green: 212/255, blue: 212/255, alpha: 1)
        self.tintColor = UIColor(displayP3Red: 151/255, green: 151/255, blue: 151/255, alpha: 1)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
