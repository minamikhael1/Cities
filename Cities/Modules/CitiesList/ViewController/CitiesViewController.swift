//
//  CitiesViewController.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //MARK:- Variables
    private let CityCellID = "CityCell"
    private var viewModel: CitiesViewModel?
    var coordinatorDelegate: CitiesCoordinatorDelegate?

    init(viewModel: CitiesViewModel) {
        super.init(nibName: String(describing: CitiesViewController.self), bundle: nil)
        self.viewModel = viewModel
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    //MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cities"
        if #available(iOS 13.0, *) {
            activityIndicator.style = .medium
         } else {
            activityIndicator.style = .gray
        }
        setUpTableView()
        bindViewModel()
        viewModel?.fetchCities()
    }

    //MARK:- Helpers
    private func setUpTableView() {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }

    private func show(loading: Bool) {
        DispatchQueue.main.async {
            self.tableView.isHidden = loading
            self.activityIndicator.isHidden = !loading
            self.searchBar.isHidden = loading
            loading == true ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }

    //MARK:- Data binding
    private func bindViewModel() {
        viewModel?.cities.bind {[weak self] _ in
            DispatchQueue.main.async {
                self?.tableView?.reloadData()
            }
        }

        viewModel?.state.bind({[weak self] state in
            switch state {
            case .loading:
                self?.show(loading: true)
            case .finishedLoading:
                self?.show(loading: false)
            case .error(let error):
                self?.show(loading: false)
                self?.presentNetworkError(error: error)
            }
        })
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.emptySearch() == true ? 1 : viewModel?.cities.value.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: CityCellID)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: CityCellID)
        }
        cell?.textLabel?.text = viewModel?.cityCellTitle(for: indexPath.row)
        cell?.detailTextLabel?.text = viewModel?.cityCellSubtitle(for: indexPath.row)
        cell?.accessoryType = viewModel?.cityCellAccessory(for: indexPath.row) ?? .none
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cityViewModel = viewModel?.cities.value[indexPath.row] else { return }
        coordinatorDelegate?.citySelected(city: cityViewModel)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

//MARK:- UISearchBarDelegate
extension CitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchTextChanged(query: searchBar.text)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel?.searchDidBeginEditing(query: searchBar.text)
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        viewModel?.resetSearch()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
