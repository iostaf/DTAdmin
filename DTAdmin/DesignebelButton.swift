//
//  DesignebelButton.swift
//  DTAdmin
//
//  Created by ITA student on 11/10/17.
//  Copyright © 2017 if-ios-077. All rights reserved.
//

import UIKit

class DesignebelButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = UIColor.blue.withAlphaComponent(0.75)
        self.tintColor = UIColor.white
    }

}
