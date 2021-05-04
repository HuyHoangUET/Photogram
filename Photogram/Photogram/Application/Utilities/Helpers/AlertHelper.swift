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
        let titleAlertAction = "Ok"
        let titleAlertController = "\(title) error:"
        
        let alertController = UIAlertController(title: titleAlertController, message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        
        let alertAction = UIAlertAction(title: titleAlertAction, style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAction)
        view.present(alertController, animated: true, completion: nil)
    }
}
