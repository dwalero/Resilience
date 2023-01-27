//
//  HomeViewController.swift
//  Resilience
//
//  Created by Damien WALEROWICZ on 25/01/2023.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBAction func startQuestions() {
        guard var questions = JsonLoader.loadJson(named: "data") else { return }
        questions = questions.sorted{ $0.order ?? 0 < $1.order ?? 0 }

        let controller = QuestionNavigationController(with: questions)
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
}
