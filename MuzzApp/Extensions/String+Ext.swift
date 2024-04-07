//
//  String+Ext.swift
//  MuzzApp
//
//  Created by hanif hussain on 05/04/2024.
//

import Foundation

extension String {
    
    func convertDateToString(date: Date) -> String {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return outputFormatter.string(from: date)
    }
}
