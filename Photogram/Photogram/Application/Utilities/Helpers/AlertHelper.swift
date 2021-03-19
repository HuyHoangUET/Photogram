//
//  AlertHelper.swift
//  Photogram
//
//  Created by LTT on 19/03/2021.
//

import Foundation
import UIKit

final class AlertHelper {
    private var error: String
    private var title: String
    private var navigationController: UINavigationController
    
    init(error: String, title: String, navigationController: UINavigationController) {
        self.error = error
        self.title = title
        self.navigationController = navigationController
    }
    
    func presentAlert() {
        let alertController = UIAlertController(title: "\(title) error:", message: error, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAction)
        navigationController.present(alertController, animated: true, completion: nil)
    }
}
