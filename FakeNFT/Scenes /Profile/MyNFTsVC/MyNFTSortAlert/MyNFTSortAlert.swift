//
//  MyNFTSortAlert.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 28.5.2024.
//

import UIKit

struct SortAction {
    let title: String
    let action: () -> Void
}

final class MyNFTSortAlert {
    
    func showSortingAlert(actions: [SortAction]) -> UIAlertController {
        
        let sortAlert = UIAlertController(
            title: "Сортировка",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        actions.forEach { sortAction in
            let alertAction = UIAlertAction(
                title: sortAction.title,
                style: .default
            ) { _ in
                sortAction.action()
            }
            sortAlert.addAction(alertAction)
        }
        
        let closeAction = UIAlertAction(
            title: "Закрыть",
            style: .cancel
        )
        
        sortAlert.addAction(closeAction)
        
        return sortAlert
    }
}
