//
//  File.swift
//  
//
//  Created by Neeraj soni on 16/02/25.
//

import Foundation
public protocol LocalizationProvider {
    func localized(_ key: String) -> String
}
