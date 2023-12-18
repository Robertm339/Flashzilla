//
//  FileManager-DocumentsDirectory.swift
//  FlashZilla
//
//  Created by Robert Martinez on 6/21/22.
//

import Foundation

extension FileManager {
    static var documentsDrectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
