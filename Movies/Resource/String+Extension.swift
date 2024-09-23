//
//  String+Extension.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 23/09/24.
//

import Foundation

extension String {
    func  localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
