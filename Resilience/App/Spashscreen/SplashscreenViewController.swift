//
//  SplashscreenViewController.swift
//  Resilience
//
//  Created by Damien WALEROWICZ on 25/01/2023.
//

import Foundation
import UIKit

class SpashscreenViewController : UIViewController {
    let root = RootViewController()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.root.modalPresentationStyle = .fullScreen
        
        guard let homeViewController = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() else { return }
        
        self.root.viewControllers = [homeViewController]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.present(self.root, animated: true)
        }

    }
    
}
