//
//  SearchViewController.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import UIKit
import Combine

final class SearchViewController: BaseViewController {
    
    enum Section: Hashable {
        case main
    }
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    private var dataSource: UITableViewDiffableDataSource<Section, SearchModel>? = nil
    
    private let searchTrigger = PassthroughSubject<String, Never>()
    private let selectUserTrigger = PassthroughSubject<IndexPath, Never>()
    
    var data: ItemSearchResponse? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func setupUI() {
        super.setupUI()
        title = "Search"
        setupTableView()
        configDataSource()
    }
    
    private func configDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, SearchModel>(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(cell: SearchTableViewCell.self, indexPath: indexPath)
            cell.accessoryType = .disclosureIndicator
            cell.config(data: itemIdentifier)
            return cell
        })
        dataSource?.defaultRowAnimation = .fade
    }
    
    private func setupTableView() {
        tableView.register(cell: SearchTableViewCell.self)
        tableView.delegate = self
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewmodel = viewModel as? SearchViewModel else { return }
        
        let input = SearchViewModel.Input(
            loadTrigger: Just(()).eraseToAnyPublisher(),
            searchTrigger: searchTrigger
                .throttle(for: 1, scheduler: RunLoop.main, latest: true)
                .eraseToAnyPublisher(),
            selectUserTrigger: selectUserTrigger.eraseToAnyPublisher()
        )
        
        let output = viewmodel.transform(input, disposeBag)
        output.$response
            .subscribe(repoSubscriber)
    }
}

extension SearchViewController {
    private var repoSubscriber: Binder<ItemSearchResponse?> {
        Binder(self) { vc, repos in
            var snapshot = NSDiffableDataSourceSnapshot<Section, SearchModel>()
            snapshot.appendSections([.main])
            snapshot.appendItems(repos?.items ?? [], toSection: .main)
            vc.dataSource?.apply(snapshot, animatingDifferences: true)
            DispatchQueue.main.async {
                guard let repoList = repos?.items else { return }
                repoList.isEmpty
                ? vc.tableView.setNoDataView(content: "No Data", icons: "")
                : vc.tableView.removeNodataView()
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchBar.endEditing(true)
        selectUserTrigger.send(indexPath)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTrigger.send(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchTrigger.send("")
    }
}
