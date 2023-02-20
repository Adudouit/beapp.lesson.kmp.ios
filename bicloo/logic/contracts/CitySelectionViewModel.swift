//
//  CitySelectionViewModel.swift
//  Bicloo
//
//  Created by Anthony Dudouit on136/09/2022.
//

import Foundation
import Combine
import BiclooKit

class CitySelectionViewModel: ObservableObject {

    private let restManager = DataSource.shared

	private var originalContracts: [ContractEntity] = []

	@Published var contracts: [ContractEntity] = []
	@Published private(set) var isLoading: Bool = false
	@Published var throwable: StationsError?

	init() {
		fetchContracts()
	}

	func fetchContracts() {
        restManager.getContracts { contracts, error in
            if let error_ = error {
                print("ERROR \(error_)")
            }
            if let contracts_ = contracts {
                self.contracts = contracts_
            }
        }

	}



	func searchForContract(_ search: String) {

		if originalContracts.isEmpty {
			originalContracts = contracts
		}

		if search.isEmpty {
			contracts = originalContracts
			return
		}

		contracts = originalContracts.filter({ contract in
			contract.name.lowercased().contains(search.lowercased())
		})
	}

}
