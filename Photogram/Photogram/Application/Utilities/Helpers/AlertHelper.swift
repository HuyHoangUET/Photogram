//
//  AlertHelper.swift
//  Photogram
//
//  Created by LTT on 19/03/2021.
//

import Foundation
import UIKit

class AlertHelper {
    
    static var shared = AlertHelper()
    
    func presentAlert(title: String, error: NSError, view: UIViewController) {
        let alertController = UIAlertController(title: "\(title) error:", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAction)
        view.present(alertController, animated: true, completion: nil)
    }
}
