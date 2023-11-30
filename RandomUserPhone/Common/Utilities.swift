//
//  Utilities.swift
//  RandomUserPhone
//
//  Created by Jonashio on 29/11/23.
//

import UIKit

struct Utilities {
    static func callPhone(_ num: String) {
        let tel = "tel://"
        let formattedString = tel + num
        guard let url = URL(string: formattedString) else { return }
        UIApplication.shared.open(url)
    }
}
