//
//  ViewModels.swift
//  Gerry-s-Card
//
//  Created by Nicholas Tian on 28/09/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import UIKit

struct CardsViewModel {
    let card: Cards

    var displayColor: UIColor {
        switch card {
        case .faul:
            return .red
        case .offline:
            return .yellow
        }
    }
}
