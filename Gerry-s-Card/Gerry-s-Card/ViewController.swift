//
//  ViewController.swift
//  Gerry-s-Card
//
//  Created by Nicholas Tian on 28/09/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        store.subscribe { [weak self] store in
            guard let `self` = self else { return }

            self.view.backgroundColor = CardsViewModel(card: store.state).displayColor
        }

        self.button.addTarget(self, action: #selector(ViewController.tapped), for: .touchUpInside)
    }

    @objc private func tapped() {
        store.dispatch(ToggleCard())
    }
}

