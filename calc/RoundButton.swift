//
//  RoundButton.swift
//  calc
//
//  Created by iOSDev on 2021/06/08.
//

import UIKit

class RoundButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.cornerRadius = frame.width / 2
        
    }
}
