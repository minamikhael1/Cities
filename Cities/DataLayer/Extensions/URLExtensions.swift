//
//  URLExtensions.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation

extension URL {
    init(service: FileLoadService) {
        let path = Bundle.main.path(forResource: service.filePath, ofType: service.fileType) ?? ""
        self.init(fileURLWithPath: path)
    }
}
