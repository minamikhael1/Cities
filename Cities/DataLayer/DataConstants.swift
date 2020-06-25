//
//  DataConstants.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation

struct DataConstants {
    static let citiesSourceFile = "cities"
    static let sourceFileType = "json"
}

enum DataResponse<T> {
    case success(T)
    case failure(DataError)
}

enum DataError {
    case unknown
    case dataLocation
    case noJSONData
    case JSONDecoder
}

enum FetchingDataState: Equatable {
    case loading
    case finishedLoading
    case error(DataError?)
}
