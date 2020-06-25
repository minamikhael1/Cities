//
//  FileLoadService.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation

protocol FileLoadService {
    var filePath: String { get }
    var fileType: String { get }
}
