//
//  ErrorMessages.swift
//  News App
//
//  Created by Юрий Могорита on 26.10.2020.
//  Copyright © 2020 Yuri Mogorita. All rights reserved.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidData = "Can not parce data from server"
    case unableToComplete = "Unable to complete your request, please check your connection"
    case noInternetConnection = "No internet connection"
}
