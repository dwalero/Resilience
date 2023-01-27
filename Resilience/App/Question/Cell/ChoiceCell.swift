//
//  ChoiceCell.swift
//  Resilience
//
//  Created by Damien WALEROWICZ on 26/01/2023.
//

import Foundation
import UIKit

class ChoiceCell: UITableViewCell {
    var choice: Choice?
    var delegate: CellInfo?
    
    @IBOutlet var infoButton:UIButton!
    
    func setChoice(choice: Choice) {
        self.choice = choice
        
        textLabel?.text = choice.name ?? ""
        infoButton.isHidden = choice.description == nil
    }
    
    @IBAction func info() {
        guard let choice = choice, let desc = choice.description else { return }
        delegate?.displayInfo(info: desc)
    }
    
}
