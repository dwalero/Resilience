//
//  EndingViewController.swift
//  Resilience
//
//  Created by Damien WALEROWICZ on 25/01/2023.
//

import Foundation
import UIKit

class EndingViewCOntroller : UIViewController {
    var responses: [Response]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func ending() {
        sendResponses()
        self.navigationController?.dismiss(animated: true)
    }
    
    //if api call use closure
    func sendResponses() {
        guard let responses = responses else { return }
        do {
            //force unwrap for exemple
            let stringToDisplay = try String(data: JSONEncoder().encode(responses), encoding: .utf8)!
            print( stringToDisplay )
        }catch {}
    }
    
}
