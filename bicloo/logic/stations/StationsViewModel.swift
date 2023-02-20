//
//  StationsViewModel.swift
//  Bicloo
//
//  Created by Anthony Dudouit on 13/09/2022.
//

import Foundation
import Combine
import BiclooKit

enum StationsError: Error {
    case apiError
}

class StationsViewModel: ObservableObject {

    private let restManager = DataSource.shared

	@Published var stations: [StationEntity] = []
	@Published private(set) var isLoading: Bool = false
	@Published var throwable: StationsError?

	public static let shared = StationsViewModel()

	private init() {}

    func fetchStations(contract: ContractEntity) {
        isLoading = true
        DataSource.shared.getStationsOfCity(city: contract.name) { stations, error in
            if let error_ = error {
                print("ERROR \(error)")
            }
            if let stations_ = stations {
                self.stations = stations_
            }
        }


    }

}
