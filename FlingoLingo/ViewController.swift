//
//  ViewController.swift
//  FlingoLingo
//
//  Created by Барбашина Яна on 12.04.2023.
//

import UIKit
import Authorization

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .purple
        let nek = DictionaryViewController()
        nek.modalPresentationStyle = .fullScreen
        self.present(nek, animated: true)
    }


}

