//
//  DataClient.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation

class DataClient: CitiesFileServiceAPI {

    /**
    //     Call this method to perfom a web service of type `FileLoadService`
    //     - Parameter type: is generic type should be a model that confirm to `Codable` protocol
    //     - Parameter completion: result of type `DataResponse`.
    // */
    private func load<T>(type: T.Type, service: FileLoadService, completion: @escaping (DataResponse<T>) -> ()) where T: Decodable {
        DispatchQueue.global(qos: .userInitiated).async {
            let fileUrl = URL(service: service)
            do {
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.JSONDecoder))
            }
        }
    }

    //MARK:- Services
    func getCities(service: FileLoadService, completion: @escaping (DataResponse<[City]>) -> ()) {
        self.load(type: [City].self, service: service, completion: completion)
    }
}
