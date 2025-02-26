//
//  AnalyticsService.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 26.02.2025.
//

import Foundation
import YandexMobileMetrica

struct AnalyticsService {
    static func activate() {
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: "d52adedf-ae3a-4b97-a77d-cfd1f8456cdd") else { return }
        
        YMMYandexMetrica.activate(with: configuration)
    }
    
    func report(event: String, params : [AnyHashable : Any]) {
        YMMYandexMetrica.reportEvent(event, parameters: params, onFailure: { error in
            print("REPORT ERROR: %@", error.localizedDescription)
        })
    }
}

