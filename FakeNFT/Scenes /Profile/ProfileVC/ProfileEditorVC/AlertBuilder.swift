//
//  AlertBuilder.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 5.6.2024.
//

import UIKit

final class AlertBuilder {
    
    static func createEditPhotoAlert(
        currentURL: String,
        completion: @escaping (String) -> Void
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: "Edit Photo URL",
            message: "Enter new photo URL",
            preferredStyle: .alert
        )
        
        alertController.addTextField { textField in
            textField.placeholder = "Photo URL"
            textField.text = currentURL
            textField.clearButtonMode = .whileEditing
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let textField = alertController.textFields?.first, 
               let newURL = textField.text {
                completion(newURL)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        return alertController
    }
}

