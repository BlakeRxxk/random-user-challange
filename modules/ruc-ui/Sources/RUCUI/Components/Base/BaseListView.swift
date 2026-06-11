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
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.showsSeparators = true
        config.separatorConfiguration.color = UIColor.border(.subtle)
        config.separatorConfiguration.topSeparatorVisibility = .hidden
        let layout = UICollectionViewCompositionalLayout.list(using: config)

        collectionView = UICollectionView(
            frame: bounds,
            collectionViewLayout: layout,
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
