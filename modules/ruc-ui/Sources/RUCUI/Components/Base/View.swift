//
//  View.swift
//  RUCUI
//

import UIKit

open class View: UIView {
    public init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable, message: "NSCoder and Interface Builder is not supported. Use Programmatic layout.")
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
