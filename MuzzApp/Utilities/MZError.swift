//
//  MZError.swift
//  MuzzApp
//
//  Created by hanif hussain on 07/04/2024.
//

import Foundation

enum MZError: String, Error {
    case invalidUsername = "Username does not exist"
    case unableToCompleteRequest = "Unable to complete your request. Please check your network."
    case invalidResponseFromServer = "Invalid response from server. Please try again."
    case unableToCreateUser = "Unable to create user"
}
