//
//  UITableViewIdentifiable.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellClass: T.Type) where T: ClassIdentifiable {
        register(cellClass.self, forCellReuseIdentifier: cellClass.reuseId)
    }

    func register<T: UITableViewCell>(cellType: T.Type) where T: NibReusable {
        register(cellType.nib, forCellReuseIdentifier: cellType.reuseId)
    }

    func register<T: UIView>(headerFooterType: T.Type) where T: NibReusable {
        register(headerFooterType.nib, forHeaderFooterViewReuseIdentifier: headerFooterType.reuseId)
    }
    
    func register<T: UIView>(headerFooterClassType: T.Type) where T: NibReusable {
        register(headerFooterClassType.self, forHeaderFooterViewReuseIdentifier: headerFooterClassType.reuseId)
    }

    func dequeueReusableCell<T: UITableViewCell>(withCellType type: T.Type = T.self) -> T where T: ClassIdentifiable {
        guard let cell = dequeueReusableCell(withIdentifier: type.reuseId) as? T else { fatalError() }

        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>(withCellType type: T.Type = T.self, forIndexPath indexPath: IndexPath) -> T where T: ClassIdentifiable {
        guard let cell = dequeueReusableCell(withIdentifier: type.reuseId, for: indexPath) as? T else { fatalError() }

        return cell
    }

    func dequeueReusableHeaderFooterView<T: UIView>(headerFooterType type: T.Type) -> T where T: ClassIdentifiable {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: type.reuseId) as? T else { fatalError() }

        return view
    }
}
