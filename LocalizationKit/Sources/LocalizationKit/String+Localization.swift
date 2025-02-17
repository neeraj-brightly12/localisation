//
//  File.swift
//  
//
//  Created by Neeraj soni on 16/02/25.
//

public extension String {
    var localized: String {
        return Localization().localized(self)
    }
}

