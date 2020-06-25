//
//  CitiesFileService.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation

class CitiesFileService: FileLoadService {
    var filePath: String {
        return DataConstants.citiesSourceFile
    }

    var fileType: String {
        return DataConstants.sourceFileType
    }
}

protocol CitiesFileServiceAPI {
    func getCities(service: FileLoadService, completion: @escaping (_ result: DataResponse<[City]>) -> ())
}
