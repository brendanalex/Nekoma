//
//  GameView.swift
//  Nekoma
//
//  Created by Brendan Alexander Soendjojo on 07/06/24.
//

import SwiftUI

struct GameView: View {
    @StateObject var game = StartGame()

    func printChestsContent() {
        for chest in game.chests {
            if let content = chest.content {
                switch content {
                case .weapon(let weapon):
                    print("Chest \(chest.id) contains a weapon: \(weapon.name)")
                case .fish(let fish):
                    print("Chest \(chest.id) contains a fish: \(fish.name)")
                }
            } else {
                print("Chest \(chest.id) is empty")
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Chests Content:")
                .font(.title)
                .padding()

            ForEach(game.chests.indices, id: \.self) { index in
                if let content = game.chests[index].content {
                    switch content {
                    case .weapon(let weapon):
                        Text("Chest \(index + 1): Weapon - \(weapon.name)")
                    case .fish(let fish):
                        Text("Chest \(index + 1): Fish - \(fish.id)")
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
