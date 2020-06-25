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
        setupView()
        bindViewModel()
        viewModel?.fetchCities()
    }

    //MARK:- Helpers
    private func setupView() {
        setupNavigation()
        setUpTableView()
    }

    private func setupNavigation() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "tmdb"))
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setUpTableView() {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }

    private func show(loading: Bool) {
         DispatchQueue.main.async {
             self.tableView.isHidden = loading
             self.activityIndicator.isHidden = !loading
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
        return viewModel?.cities.value.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: CityCellID)
         if cell == nil {
             cell = UITableViewCell(style: .subtitle, reuseIdentifier: CityCellID)
             cell?.accessoryType = .disclosureIndicator
         }
         let cityVM = viewModel?.cities.value[indexPath.row]
         cell?.textLabel?.text = cityVM?.cityName()
         cell?.detailTextLabel?.text = cityVM?.cityCoordsDescription()
         return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
