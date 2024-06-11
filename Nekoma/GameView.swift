//
//  GameView.swift
//  Nekoma
//
//  Created by Brendan Alexander Soendjojo on 07/06/24.
//

import SwiftUI

struct GameView: View {
    @StateObject var game = StartGame()
    
    var body: some View {
        VStack {
            Text("Chests Content:")
                .font(.title)
                .padding()

            ForEach(game.chests!.indices, id: \.self) { index in
                if let content = game.chests![index].content {
                    switch content {
                    case .weapon(let weapon):
                        Text("Chest \(index + 1): Weapon - \(weapon.name)")
                    case .fish(let fish):
                        Text("Chest \(index + 1): Fish - \(fish.name)")
                    }
                } else {
                    Text("Chest \(index + 1): Empty")
                }
            }
        }
    }
}


#Preview {
    GameView()
}
