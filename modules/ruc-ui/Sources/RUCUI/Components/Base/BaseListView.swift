//
//  BaseListView.swift
//  RUCUI
//

import UIKit

open class BaseListView: View {

    // MARK: Lifecycle

    override public init() {
        super.init()

        createUI()
        configureUI()
    }

    // MARK: Open

    open func createUI() {
        collectionView = UICollectionView(
            frame: bounds,
            collectionViewLayout: .defaultLayout(),
        )

        guard let collectionView else { return }
        addSubview(collectionView)
    }

    open func configureUI() {
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.backgroundColor = .background(.primary)
    }

    // MARK: Public

    public private(set) var collectionView: UICollectionView?

}
