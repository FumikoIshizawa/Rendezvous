//
//  SearchTextBox.swift
//  Rendezvous
//
//  Created by fumiko-ishizawa on 2017/09/21.
//  Copyright © 2017年 fumikoi. All rights reserved.
//

import Foundation

//import Contacts
import MapKit

class SearchTextBox: UIView {

    private var textFieldCompletion: ((String) -> Void)?

    init(frame: CGRect, searchText: String, completion: ((String) -> Void)?) {
        super.init(frame: frame)

        self.textFieldCompletion = completion

        // View for textField
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.layer.borderWidth = 1.0

        // Search textField
        let textField: UITextField = UITextField()
        textField.frame = CGRect(x: 16, y: 8, width: self.bounds.width - 32, height: 32)
        textField.placeholder = searchText
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .search
        textField.delegate = self
        self.addSubview(textField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: UITextField Delegate
extension SearchTextBox: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text: String = textField.text {
            self.textFieldCompletion?(text)
        }
        return true
    }
}
