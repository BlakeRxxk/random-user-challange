//
//  HostingView.swift
//  RUCUI
//

import SwiftUI

open class HostingView<Content: SwiftUI.View>: View {

    // MARK: Lifecycle

    public init(rootView: Content) {
        hostingController = UIHostingController(rootView: rootView)
        hostingController.view.backgroundColor = .clear
        super.init()
        addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    // MARK: Private

    private let hostingController: UIHostingController<Content>

}
