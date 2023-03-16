//
//  Home.swift
//  CryptoTracker
//
//  Created by Akari on 16.03.23.
//

import SwiftUI

struct Home: View {
    @State var currentTab: String = "Crypto"
    @Namespace var animation
    @StateObject var appModel: AppViewModel = .init()
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10){
                    if let coins = appModel.coins{
                        ForEach(coins){coin in
                            VStack(spacing: 8){
                                CardView(coin: coin)
                                Divider()
                            }
                            .padding(.horizontal)
                            .padding(.vertical,8)
                        }
                    }
                }
            }
            
            HStack{
                Button {
                    
                } label: {
                    Image("1")
                }
                
                Spacer()
                Button {
                    
                } label: {
                   Text("xolokillua")
                }
            }
            .padding(.horizontal)
            .padding(.vertical,10)
            .background{Color.black}
        }
        .frame(width: 320, height: 450)
        .background{Color("BG")}
        .preferredColorScheme(.dark)
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    func CardView(coin: CryptoModel)->some View{
        HStack{
            VStack(alignment: .leading, spacing: 6) {
                Text(coin.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(width: 80,alignment: .leading)
            
            LineGraph(data: coin.last_7days_price.price,profit: coin.price_change > 0)
                .padding(.horizontal,10)
            
            VStack(alignment: .trailing, spacing: 6) {
                Text(coin.current_price.convertToCurrency())
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text("\(coin.price_change > 0 ? "+" : "")\(String(format: "%.2f", coin.price_change))")
                    .font(.caption)
                    .foregroundColor(coin.price_change > 0 ? Color("LightGreen") : .red)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension Double{
    func convertToCurrency()->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        formatter.locale = Locale(identifier: "en_US")
        
        return formatter.string(from: .init(value: self)) ?? ""
    }
}
