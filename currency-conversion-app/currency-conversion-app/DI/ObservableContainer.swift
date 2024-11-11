//
//  ObservableContainer.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 30/10/24.
//

import Swinject
import Combine

class ObservableContainer: ObservableObject {
    let container: Container
    
    init(container: Container) {
        self.container = container
    }
}
