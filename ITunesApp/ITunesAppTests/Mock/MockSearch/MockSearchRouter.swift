//
//  MockSearchRouter.swift
//  ITunesAppTests
//
//  Created by serdar on 15.06.2023.
//

import Foundation
@testable import ITunesApp

final class MockSearchRouter: SearchRouterProtocol{

    var isInvokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (route: SearchRoutes, Void)?
    
    func navigateTo(_ route: ITunesApp.SearchRoutes) {
        isInvokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (route, ())
    }
    
    
}
