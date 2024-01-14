//
//  UICollectionView+Identifiable.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import UIKit

extension UICollectionView {
    func register<C: UICollectionViewCell>(cellType: C.Type) where C: ClassIdentifiable {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseId)
    }

    func register<C: UICollectionViewCell>(cellType: C.Type) where C: NibReusable {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseId)
    }

    func register<C: UICollectionReusableView>(cellType: C.Type, ofKind kind: String) where C: NibReusable {
        register(cellType.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: cellType.reuseId)
    }

    func dequeueReusableCell<C: UICollectionViewCell>(withCellType type: C.Type = C.self, forIndexPath indexPath: IndexPath) -> C where C: ClassIdentifiable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.reuseId, for: indexPath) as? C else { fatalError() }

        return cell
    }

    func dequeueReusableSupplementaryView<C: UICollectionReusableView>(withViewType type: C.Type = C.self, ofKind kind: String, forIndexPath indexPath: IndexPath) -> C where C: ClassIdentifiable {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.reuseId, for: indexPath) as? C else { fatalError() }

        return view
    }
}
