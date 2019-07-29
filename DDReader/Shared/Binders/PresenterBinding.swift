//
//  ShowErrorBinder.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation
import RxCocoa

protocol Presenter: class {
    func show(_ vc: UIViewController, sender: Any?)
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}

extension UIViewController: Presenter { }

extension Presenter {

    func showErrorBinder() -> Binder<Error> {
        return Binder(self) { (self, error) in
            let alertTitle: String?
            let alertMessage: String
            if let displayableError = error as? DisplayableError {
                alertTitle = displayableError.title
                alertMessage = displayableError.message
            } else {
                alertTitle = "Error"
                alertMessage = error.localizedDescription
            }

            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
                alertController.dismiss(animated: true, completion: nil)
            }))

            self.present(alertController, animated: true, completion: nil)
        }
    }

    func showDetail() -> Binder<UIViewController> {
        return Binder(self) { (self, controller) in
            self.show(controller, sender: nil)
        }
    }

}
