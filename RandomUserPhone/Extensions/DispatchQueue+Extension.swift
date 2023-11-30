//
//  DispatchQueue+Extension.swift
//  RandomUserPhone
//
//  Created by Jonashio on 29/11/23.
//

import Foundation

extension DispatchQueue {
    static func mainAfter(deadline: DispatchTime, completion: @escaping (() -> Void)) {
        DispatchQueue.global().asyncAfter(deadline: deadline) { DispatchQueue.main.sync { completion() }}
    }
}
