//
//  AlertManager.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/24.
//

import Foundation
import UIKit

struct AlertManager {
  
  let rootController: UIViewController? = {
    let app = UIApplication.shared.delegate as! SceneDelegate
    return app.window?.rootViewController
  }()
  
  let activityIndicator = UIActivityIndicatorView()
  
  func showAlert(withMessage message: String, title: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(okAction)
    rootController?.present(alertController, animated: true, completion: nil)
  }
  
}
