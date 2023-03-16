//
//  ViewModel.swift
//  CryptoTracker
//
//  Created by Akari on 16.03.23.
//

import SwiftUI

class AppViewModel: ObservableObject {
    @Published var coins: [CryptoModel]?
    @Published var currentCoin: CryptoModel?
    
    init(){
        Task{
            do{
                try await fetchCryptoData()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCryptoData()async throws{
        guard let url = url else{return}
        let session = URLSession.shared
        
        let response = try await session.data(from: url)
        let jsonData = try JSONDecoder().decode([CryptoModel].self, from: response.0)
        
        await MainActor.run(body: {
            self.coins = jsonData
            if let firstCoin = jsonData.first{
                self.currentCoin = firstCoin
            }
        })
    }
}
