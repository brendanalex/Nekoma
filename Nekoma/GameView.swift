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
            
            ForEach(game.chests!) { chest in
                if let content = chest.content {
                    switch content {
                    case .single(let type):
                        switch type {
                        case .weapon(let weapon):
                            Text("Chest \(chest.id): Weapon - \(weapon.name)")
                        case .fish(let fish):
                            Text("Chest \(chest.id): Fish - \(fish.name)")
                        }
                    case .multiple(let types):
                        // Handle multiple types of content
                        Text("Chest \(chest.id): Multiple - \(types.count) items")
                    }
                } else {
                    Text("Chest \(chest.id): Empty")
                }
            }
        }
    }
}


#Preview {
    GameView()
}
