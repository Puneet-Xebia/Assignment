//  Smart Dubai
//
//  Created by Puneet kumar  on 15/06/20.
//  Copyright © 2020 Puneet Kumar. All rights reserved.
//

import Foundation

enum ErrorResponse:String {
    case invalidJson = "Invalid response. Data cannot be decoded."
    case authenticationfailure = "You need to be authenticated first."
    case badRequest = "Bad request"
    case noInternetConnection = "Internet connection not available"
    case serverValidationError = "Server validation Error"
    case internalServerError = "Internal server error"
    case unknownError = "Unknown error"
}


enum Result<String>{
    case success
    case failure(ErrorResponse)
}

class APIRequestError {
    
    var errorCode: Int?
    
    var errorTitle: String?{
        return nil
    }
    
    var errorMessage: String?{
        return nil
    }
    
    var error : String?
    
    var dictError : Dictionary<String,Any>?
}

