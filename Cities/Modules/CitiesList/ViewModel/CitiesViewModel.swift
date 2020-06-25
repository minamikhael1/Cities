//
//  CitiesViewModel.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation

class CitiesViewModel {

    //MARK:- Properties
    private (set) var state: Bindable<FetchingDataState> = Bindable(.loading)
    private let dataClient: DataClient
    private (set) var cities: Bindable<[CityViewModel]> = Bindable([])

    //MARK:- init
    //init CitiesViewModel with dependency injection of data client object
    //to be able to mock the data layer for unit testing
    init(dataClient: DataClient = DataClient()) {
        self.dataClient = dataClient
    }

    //MARK:- Helpers
    func fetchCities() {
        state.value = .loading
        dataClient.getCities(service: CitiesFileService()) { [weak self] response in
            switch response {
            case .success(let result):
                self?.cities.value = result.map({ CityViewModel(city: $0) })
            case .failure(let error):
                self?.state.value = .error(error)
            }
            self?.state.value = .finishedLoading
        }
    }
}
