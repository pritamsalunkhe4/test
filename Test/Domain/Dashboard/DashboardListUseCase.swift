//
//  DashboardListUseCase.swift
//  Test
//
//  Created by PritamSing Salunkhe on 09/08/21.
//

typealias Completion = (_ success: Bool, _ data: [FilterResponseModel]?, _ error: Error?) -> Void

import Foundation

protocol DashboardListUseCase {
}

class DashboardListUseCaseImplementation: DashboardListUseCase {
    private var service: DashboardService?
    
    init(service: DashboardService) {
        self.service = service
    }
}
