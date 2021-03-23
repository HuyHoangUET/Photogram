//
//  HomeTabbarNavigator.swift
//  Photogram
//
//  Created by LTT on 10/03/2021.
//

import Foundation
import UIKit

protocol HomeTabbarNavigator {
}

class DefaultHomeTabbarNavigator: HomeTabbarNavigator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
