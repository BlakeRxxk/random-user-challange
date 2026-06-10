//
//  ViewController.swift
//  RUCUI
//

import UIKit

open class ViewController<View: UIView>: UIViewController {

    // MARK: Lifecycle

    public init(viewCreator: @escaping () -> View) {
        self.viewCreator = viewCreator
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "NSCoder and Interface Builder is not supported. Use Programmatic layout.")
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Open

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        navigationController?.preferredStatusBarStyle ?? .default
    }

    // MARK: Public

    public var specializedView: View {
        unsafeDowncast(view, to: View.self)
    }

    override public func loadView() {
        view = viewCreator()
        view.backgroundColor = .background(.primary)
    }

    // MARK: Private

    private let viewCreator: () -> View

}
