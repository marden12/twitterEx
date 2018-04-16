//
//  HashTagView.swift
//  SearchBar
//
//  Created by Бекболат Куанышев on 16.04.2018.
//  Copyright © 2018 Bekbolat. All rights reserved.
//

import UIKit

class HashTagViewController: UIViewController {
    
    var text = ""
    
    private lazy var tagLabel : UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.backgroundColor = .green
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tagLabel)
        
        tagLabel.frame = CGRect(x: 50, y: 100, width: 150, height: 50)
        tagLabel.text = text
        
        print(text)
    }
}

