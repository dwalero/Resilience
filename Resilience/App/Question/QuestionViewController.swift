//
//  QuestionViewController.swift
//  Resilience
//
//  Created by Damien WALEROWICZ on 25/01/2023.
//

import Foundation
import UIKit

protocol QuestionViewProtocol {
    func setQuestion(question:Question)
    func next()
}


class QuestionNavigationController: UINavigationController {
    var questions: [Question]
    var currentQuestionIndex = 0
    var responses: [Response] = [Response]()
    
    init(with questions:[Question]) {
        let questionVC = UIStoryboard(name: "Question", bundle: nil).instantiateViewController(withIdentifier: "ChoiceQuestion" ) as? ChoiceQuestionViewController
        questionVC!.setQuestion(question: questions.first!)
        self.questions = questions
        super.init(rootViewController: questionVC! )
        self.responses.removeAll()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func back() {
        currentQuestionIndex -= 1
    }
    
    func next(response: Response) {
        currentQuestionIndex += 1
        responses.removeAll{ $0.id == response.id}
        responses.append(response)

        
        if currentQuestionIndex < questions.count {
            let questionVC = UIStoryboard(name: "Question", bundle: nil).instantiateViewController(withIdentifier: "ChoiceQuestion" ) as? ChoiceQuestionViewController
            questionVC!.setQuestion(question: questions[currentQuestionIndex])
            self.pushViewController(questionVC!, animated: true)
        }else{
            let endingVC = UIStoryboard(name: "Ending", bundle: nil).instantiateInitialViewController() as? EndingViewCOntroller
            endingVC?.responses = responses
            self.pushViewController(endingVC!, animated: true)
        }
        
    }
    
    
}
