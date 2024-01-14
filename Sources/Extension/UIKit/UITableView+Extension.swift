//
//  UITableView+Extension.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(cell: T.Type) {
        if let nib = T.nib, Bundle.main.path(forResource: T.className, ofType: "nib") != nil {
            register(nib, forCellReuseIdentifier: T.cellId)
        } else {
            register(T.self, forCellReuseIdentifier: T.cellId)
        }
    }
    
    func register<T: UITableViewHeaderFooterView>(view: T.Type) {
        if let nib = T.nib, Bundle.main.path(forResource: T.className, ofType: "nib") != nil {
            register(nib, forHeaderFooterViewReuseIdentifier: T.headerId)
        } else {
            register(T.self, forHeaderFooterViewReuseIdentifier: T.headerId)
        }
    }
    
    func dequeueReusableCell<T>(cell: T.Type = T.self, indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: cell.cellId, for: indexPath) as? T else {
            fatalError("Could not init \(T.className)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooter<T>(type: T.Type = T.self) -> T where T: UITableViewHeaderFooterView {
        guard let header = dequeueReusableHeaderFooterView(withIdentifier: T.headerId) as? T else {
            fatalError("Could not init \(T.className)")
        }
        return header
    }
    
    func reload<T: Equatable>(oldValue: [T], newValue: [T]) {
        let insertIndexes = newValue.enumerated().filter { repo -> Bool in
            !oldValue.contains(where: { $0 == repo.element })
        }
        let removeIndexes = oldValue.enumerated().filter { repo -> Bool in
            !newValue.contains(where: { $0 == repo.element })
        }
        let indexPathsInsert = insertIndexes.map { IndexPath(row: $0.offset, section: 0) }
        let indexPathsDelete = removeIndexes.map { IndexPath(row: $0.offset, section: 0) }
        
        beginUpdates()
        insertRows(at: indexPathsInsert, with: .top)
        deleteRows(at: indexPathsDelete, with: .top)
        endUpdates()
    }
    
    func removeRows(indexPaths: [IndexPath], animation: UITableView.RowAnimation = .top) {
        beginUpdates()
        deleteRows(at: indexPaths, with: animation)
        endUpdates()
    }
    
    func insertRows(indexPaths: [IndexPath], animation: UITableView.RowAnimation = .top) {
        beginUpdates()
        insertRows(at: indexPaths, with: animation)
        endUpdates()
    }
    
    func tableViewNoData(content: String? = nil, icons: String) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0,
                                        width: self.bounds.size.width,
                                        height: self.bounds.size.height))
        let label = UILabel()
        label.text = content
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hexString: "#7B7B7B")
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if icons.count > 0 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: icons)
            view.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -45)
            ])
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                label.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30)
            ])
        } else {
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
            ])
        }
        
        return view
    }
    
    func setNoDataView(content: String?, icons: String) {
        self.backgroundView = tableViewNoData(content: content, icons: icons)
    }
    
    func removeNodataView() {
        self.backgroundView = nil
    }
}

extension UITableViewCell {
    
    static var cellId: String {
        return className
    }
    
    static var nib: UINib? {
        return UINib(nibName: cellId, bundle: nil)
    }
    
    var tableView: UITableView? {
        var table: UIView? = superview
        while !(table is UITableView) && table != nil {
            table = table?.superview
        }
        return table as? UITableView
    }
    
}

extension UITableViewHeaderFooterView {

    static var headerId: String {
        return className
    }
    
    static var nib: UINib? {
        return UINib(nibName: headerId, bundle: Bundle.main)
    }
}

extension NSObject {
    
    var className: String {
        return type(of: self).className
    }
    
    static var className: String {
        return String.className(self)
    }
}
