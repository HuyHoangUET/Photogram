//
//  ViewController+Extension.swift
//  Photogram
//
//  Created by LTT on 23/03/2021.
//

import Foundation
import UIKit

extension UIViewController {
    static func instantiate(from storyboardName: String, withIdentifier identifier: String) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
