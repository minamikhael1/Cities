//
//  CitiesViewModel.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation
import UIKit

class CitiesViewModel {

    //MARK:- Properties
    private let dataClient: DataClient
    private (set) var state: Bindable<FetchingDataState> = Bindable(.loading)
    private (set) var cities: Bindable<[CityViewModel]> = Bindable([])
    private var allCities = [City]()
    var searchQuery: String?

    //MARK:- init
    //init CitiesViewModel with dependency injection of data client object
    //to be able to mock the data layer for unit testing
    init(dataClient: DataClient = DataClient()) {
        self.dataClient = dataClient
    }

    func fetchCities() {
        state.value = .loading
        dataClient.getCities(service: CitiesFileService()) { [weak self] response in
            switch response {
            case .success(let result):
                self?.allCities = result.sorted {$0.name < $1.name}
                self?.cities.value = self?.allCities.map({ CityViewModel(city: $0) }) ?? [CityViewModel]()
                self?.state.value = .finishedLoading
            case .failure(let error):
                self?.state.value = .error(error)
            }
        }
    }

    func searchTextChanged(query: String?) {
        searchQuery = query
        if query == nil || query?.isEmpty == true {
            resetSearch()
        } else {
            performSearch()
        }
    }

    func searchDidBeginEditing(query: String?) {
        searchQuery = query
        if query == nil || query?.isEmpty == true {
            resetSearch()
        }
    }

    func resetSearch() {
        searchQuery = nil
        DispatchQueue.global(qos: .default).async {[weak self] in
            self?.cities.value = self?.allCities.map({ CityViewModel(city: $0) }) ?? [CityViewModel]()
        }
    }

    func emptySearch() -> Bool {
        if let searchQuery = searchQuery {
            return !searchQuery.isEmpty && cities.value.count == 0
        }
        return false
    }

    // TableView related
    func cityCellTitle(for index: Int) -> String {
        return emptySearch() ? "No city found!" : cities.value[index].cityName()
    }

    func cityCellSubtitle(for index: Int) -> String? {
        return emptySearch() ? nil : cities.value[index].cityCoordsDescription()
    }

    func cityCellAccessory(for index: Int) -> UITableViewCell.AccessoryType {
        return emptySearch() ? .none : .disclosureIndicator
    }

    //MARK:- Helpers
    private func performSearch() {
        guard let query = searchQuery else { return }
        DispatchQueue.global(qos: .default).async {[weak self] in
            self?.cities.value = self?.allCities.filter({ $0.name.lowercased().hasPrefix(query.lowercased()) }).map({ CityViewModel(city: $0) }) ?? [CityViewModel]()
        }
    }
}
