//
//  SearchViewController.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    enum Section: Hashable {
        case main
    }
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    private let dataSource = BehaviorRelay<ItemSearchResponse?>(value: nil)
    
    private let searchTrigger = PublishSubject<String>()
    private let selectUserTrigger = PublishSubject<IndexPath>()
    
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
        tableView.dataSource = self
    }
    
    private func setupTableView() {
        tableView.register(cell: SearchTableViewCell.self)
        tableView.delegate = self
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewmodel = viewModel as? SearchViewModel else { return }
        
        let input = SearchViewModel.Input(
            loadTrigger: rx.viewWillAppear.mapToVoid().asDriverOnErrorJustComplete(),
            searchTrigger: searchTrigger.asDriverOnErrorJustComplete(),
            selectUserTrigger: selectUserTrigger.asDriverOnErrorJustComplete())
        
        let output = viewmodel.transform(input)
        
        output.searchResponse
            .do(onNext: { res in
                print(res)
            })
            .drive(dataSource)
            .disposed(by: rx.disposeBag)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.value?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        
        if let dataSource = dataSource.value {
            //cell.config(data: dataSource.items?[indexPath])
        }
        return cell
    }
    
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchBar.endEditing(true)
        selectUserTrigger.onNext(indexPath)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTrigger.onNext(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchTrigger.onNext("")
    }
}
