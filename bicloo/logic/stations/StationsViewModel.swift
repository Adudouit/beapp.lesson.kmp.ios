//
//  StationsViewModel.swift
//  Bicloo
//
//  Created by Anthony Dudouit on 13/09/2022.
//

import Foundation
import Combine

enum StationsError: Error {
    case apiError
}

class StationsViewModel: ObservableObject {

	private let restManager = RestManager()

	@Published var stations: [StationEntity] = []
	@Published private(set) var isLoading: Bool = false
	@Published var throwable: StationsError?

	public static let shared = StationsViewModel()

	private init() {}

	func fetchStations(contract: ContractEntity) {
		isLoading = true
		restManager.getStationsOfCity(city: contract.name)
			.catch({ [weak self] error -> Just<StationsDTO> in
				self?.throwable = StationsError.apiError
				return Just<StationsDTO>([])
			})
				.map({ [weak self] response -> [StationEntity] in
					self?.isLoading = false
					let stations_ = response.map({ StationEntity(dto: $0) })
					return stations_
				})
					.assign(to: &$stations)
	}

}
