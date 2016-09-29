//
//  ViewController.swift
//  Counter
//
//  Created by Nicholas Tian on 29/09/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addButton.addTarget(self, action: #selector(ViewController.addButtonTapped), for: .touchUpInside)
        self.minusButton.addTarget(self, action: #selector(ViewController.minusButtonTapped), for: .touchUpInside)

        store.subscribe { [weak self] store in
            guard let `self` = self else { return }

            self.counterLabel.text = "\(store.state)"
        }
    }

    @objc private func addButtonTapped() {
        store.dispatch(CounterActions.increase)
    }

    @objc private func minusButtonTapped() {
        store.dispatch(CounterActions.decrease)
    }
}

