//
//  Extensions.swift
//  MoodNotes
//
//  Created by Utkarsh Dixit on 26/7/21.
//

import Foundation
import UIKit

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension UITextField {
    
    func addUnderLine () {
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0.0, y: self.bounds.height - 1, width: self.bounds.width, height: 1)
        bottomLine.backgroundColor = UIColor(named: "TextSecondary")?.cgColor ?? UIColor.lightGray.cgColor
        
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    
}
