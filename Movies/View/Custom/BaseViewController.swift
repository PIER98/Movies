//
//  BaseViewController.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 26/09/24.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    func setupNavigationBar(title: String) {
        self.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .black
        let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = titleColor
        let standardTitleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = standardTitleColor
    }
    
    func displayAlertController(error: Error,handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "generic.error".localized(), message:error.networkError , preferredStyle: .alert)
        self.present(alert, animated: true)
        let action = UIAlertAction(title: "generic.retry".localized(), style: .default) {[weak self] _ in
            handler?()
        }
        alert.addAction(action)
    }
}
