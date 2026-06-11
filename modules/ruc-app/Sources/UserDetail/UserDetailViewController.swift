//
//  UserDetailViewController.swift
//  UserDetail
//

import RUCCore
import RUCUI
import UIKit

// MARK: - UserDetailPresentableListener

public protocol UserDetailPresentableListener: AnyObject {
    @MainActor
    func onDismiss()
}

// MARK: - UserDetailViewController

public final class UserDetailViewController: ViewController<UserDetailView>, UserDetailViewControllable {

    // MARK: Lifecycle

    init(listener: UserDetailPresentableListener? = nil) {
        self.listener = listener
        super.init(viewCreator: UserDetailView.init)
    }

    // MARK: Public

    public weak var listener: UserDetailPresentableListener?

    public var uiViewController: UIViewController {
        self
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        title = Localized.title
        addCloseButtonIfNeeded(target: self, action: #selector(handleClose))
        navigationController?.presentationController?.delegate = self
    }

    // MARK: Internal

    @objc
    func handleClose() {
        listener?.onDismiss()
    }

}

// MARK: UserDetailPresentable

extension UserDetailViewController: UserDetailPresentable {
    public func display(user: UserDetailDisplayModel) {
        specializedView.model.displayModel = user
    }
}

// MARK: UIAdaptivePresentationControllerDelegate

extension UserDetailViewController: UIAdaptivePresentationControllerDelegate {
    public func presentationControllerWillDismiss(_: UIPresentationController) {
        listener?.onDismiss()
    }
}

// MARK: UserDetailViewController.Localized

extension UserDetailViewController {
    fileprivate enum Localized {
        static let title = "User Details".localize()
    }
}
