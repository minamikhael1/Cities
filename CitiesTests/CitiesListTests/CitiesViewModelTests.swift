//
//  CitiesViewModelTests.swift
//  CitiesTests
//
//  Created by Mina Mikhael on 26.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation
import XCTest
@testable import Cities

class CitiesViewModelTests: XCTestCase {

    var dataClient = MockDataClient()

    func testSuccessFetchNowPlaying() {
        let viewModel = CitiesViewModel(dataClient: dataClient)
        viewModel.fetchCities()
        guard case FetchingDataState.finishedLoading = viewModel.state.value else {
            XCTFail()
            return
        }
        let cityVM = viewModel.cities.value[0]
        let mockCityVM = CityViewModel.getMockCityViewModel()
        XCTAssertEqual(cityVM.cityName(), mockCityVM.cityName())
        XCTAssertEqual(cityVM.cityCoordsDescription(), mockCityVM.cityCoordsDescription())
    }

    func testFailFetchNowPlaying() {
        dataClient.mockCitiesResponse = .failure(DataError.unknown)
        let viewModel = CitiesViewModel(dataClient: dataClient)
        viewModel.fetchCities()
        guard case FetchingDataState.error(_) = viewModel.state.value else {
            XCTFail()
            return
        }
    }

    func testSuccessfulSearch() {
        search(successful: true)
    }

    func testUnsuccessfulSearch() {
        search(successful: false)
    }

    func search(successful: Bool) {
        let mockSearchQuery = successful ? "am" : "amx"
        let viewModel = CitiesViewModel(dataClient: dataClient)
        viewModel.fetchCities()
        viewModel.searchTextChanged(query: mockSearchQuery)
        let cityVM: CityViewModel? = successful ? viewModel.cities.value[0] : nil
        let mockCityVM = CityViewModel.getMockCityViewModel()
        if successful {
            XCTAssertEqual(cityVM?.cityName(), mockCityVM.cityName())
            XCTAssertEqual(cityVM?.cityCoordsDescription(), mockCityVM.cityCoordsDescription())
        } else {
            XCTAssertNotEqual(cityVM?.cityName(), mockCityVM.cityName())
            XCTAssertNotEqual(cityVM?.cityCoordsDescription(), mockCityVM.cityCoordsDescription())
        }
    }
}

class MockDataClient: DataClient {

    var mockCitiesResponse: DataResponse<[City]> = .success(City.getMockFetchCitiesResponse())

    override func getCities(service: FileLoadService, completion: @escaping (DataResponse<[City]>) -> ()) {
        return completion(mockCitiesResponse)
    }
}
