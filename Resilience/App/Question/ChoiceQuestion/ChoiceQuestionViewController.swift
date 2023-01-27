//
//  ChoiceQuestionViewController.swift
//  Resilience
//
//  Created by Damien WALEROWICZ on 25/01/2023.
//

import Foundation
import UIKit

protocol CellInfo {
    func displayInfo(info:String)
}

class ChoiceQuestionViewController: UIViewController, QuestionViewProtocol {
    var question: Question?
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    func setQuestion(question:Question) {
        self.question = question
    }
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        nextButton.isEnabled = false
        tableView.allowsMultipleSelection = question?.multiple ?? false
    }
    
    func setLabel() {
        questionLabel.text = question?.question
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let nav = self.navigationController as? QuestionNavigationController else { return }

        if self.isMovingFromParent {
            nav.back()
        }
    }
    
    @IBAction func next() {
        guard let nav = self.navigationController as? QuestionNavigationController else { return }
        guard let question = question, let choices = question.choices else { return }
        
        let response = Response()
        response.id = question.id
        response.choices = tableView.indexPathsForSelectedRows!.map { $0.row }.map{ choices[$0].id }
        nav.next(response: response)
    }
    
}

extension ChoiceQuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return question?.choices?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "choice") as? ChoiceCell else { return UITableViewCell() }
        let choices = (question?.choices?.sorted { $0.order ?? 0 < $1.order ?? 0 })!
        cell.setChoice(choice: choices[indexPath.row])
        cell.delegate = self
        return cell
    }
}
extension ChoiceQuestionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedRow = tableView.indexPathsForSelectedRows {
            self.nextButton.isEnabled = !selectedRow.isEmpty
        }else{
            self.nextButton.isEnabled = false
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let selectedRow = tableView.indexPathsForSelectedRows {
            self.nextButton.isEnabled = !selectedRow.isEmpty
        }else{
            self.nextButton.isEnabled = false
        }

    }
}

extension ChoiceQuestionViewController: CellInfo {
    func displayInfo(info:String) {
        let infoPopup = UIAlertController(title: "Information", message: info, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .destructive)
        infoPopup.addAction(cancelAction)
        self.present(infoPopup, animated: true, completion: nil)
    }
}
