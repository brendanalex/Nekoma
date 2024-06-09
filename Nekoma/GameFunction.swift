//
//  GameFunction.swift
//  Nekoma
//
//  Created by Brendan Alexander Soendjojo on 08/06/24.
//

import Foundation

class StartGame: ObservableObject {
    var currentLevel: Int
    var player: Cat?
    var enemies: [Enemies] = []
    var chests: [Chest] = []
    var weapons: [Weapon] = []
    var fishes: [Fish] = []

    init() {
        // Initialize game state
        self.currentLevel = 1
        
        self.initializeWeapons()
        self.initializeFishes()
        // Initialize player with starting values
        let startingWeapon = weapons.first { $0.name == "Claw Mittens" }!
        self.player = Cat(lives: 9, baseAttack: 100, baseMovementSpeed: 20, currentWeapon: startingWeapon, storedWeapon: startingWeapon, cooldownLeft: 0)
        
        self.generateEnemies()
        self.generateChests()
    }
    
    func start() {
        // Logic to start the game
        print("Game started with player \(player), enemies \(enemies), and chests \(chests) at level \(currentLevel).")
    }

    func setupLevel(_ level: Int) {
        // Logic to setup the given level, including spawning enemies, placing chests, etc.
        self.currentLevel = level
        // Additional setup for the level can be added here
    }
    
    func initializeWeapons() {
        weapons = [
            Weapon(id: 1, name: "Claw Mittens", type: .melee, minDamage: 3, maxDamage: 5, attackSpeed: 0.3, range: 1, rarity: .common),
            Weapon(id: 2, name: "Yarn Ball", type: .ranged, minDamage: 7, maxDamage: 9, attackSpeed: 0.5, range: 2, rarity: .common),
            Weapon(id: 3, name: "Fishbone Sword", type: .melee, minDamage: 15, maxDamage: 20, attackSpeed: 1.0, range: 3, rarity: .common),
            Weapon(id: 4, name: "Laser Pointer", type: .ranged, minDamage: 2, maxDamage: 4, attackSpeed: 0.25, range: 6, rarity: .common),
            Weapon(id: 5, name: "Yakitori", type: .melee, minDamage: 8, maxDamage: 20, attackSpeed: 0.5, range: 2, rarity: .uncommon),
            Weapon(id: 6, name: "Spiked Yarn Ball", type: .ranged, minDamage: 10, maxDamage: 14, attackSpeed: 0.5, range: 3, rarity: .uncommon),
            Weapon(id: 7, name: "Moonlit Claws", type: .melee, minDamage: 5, maxDamage: 11, attackSpeed: 0.2, range: 1, rarity: .rare),
            Weapon(id: 8, name: "Rainbow Catnip Wand", type: .ranged, minDamage: 15, maxDamage: 19, attackSpeed: 0.5, range: 5, rarity: .rare)
        ]
    }
    
    func initializeFishes() {
        fishes = [
            Fish(id: 1, name: "Salmon", bonusLives: 0, bonusAttack: 0.1, bonusSpeed: 0, specialPower: SpecialPower(name: "Salmon Leap", cooldown: 5), rarity: .common),
            Fish(id: 2, name: "Sashimi", bonusLives: 1, bonusAttack: 0, bonusSpeed: 0, specialPower: SpecialPower(name: "Fresh Sashimi", cooldown: 5), rarity: .common),
            Fish(id: 3, name: "Tuna", bonusLives: 0, bonusAttack: 0, bonusSpeed: 2, specialPower: SpecialPower(name: "Tuna Terror", cooldown: 5), rarity: .common),
            Fish(id: 4, name: "Puffer Fish", bonusLives: 1, bonusAttack: 1, bonusSpeed: 1, specialPower: SpecialPower(name: "Invincibility", cooldown: 5), rarity: .common)
        ]
    }
    
    func generateEnemies() {
        enemies = [
            Enemies(id: 1, name: .flea, type: .melee, range: 1.0, healthPoints: 50, attackSpeed: 1, movementSpeed: 10),
            Enemies(id: 2, name: .rat, type: .ranged, range: 5.0, healthPoints: 40, attackSpeed: 2, movementSpeed: 8)
        ]
    }
    
    func generateChests() {
        chests = [
            Chest(id: 1, type: .common, content: getChestContent()),
            Chest(id: 2, type: .special, content: getChestContent())
        ]
    }
    
    func getChestContent() -> ChestContent? {
        let randomValue = Float.random(in: 0...1)
        print("Content: \(randomValue)")
        let rarityValue = getRarity()

        if randomValue <= 0.7 {
            // 70% chance to get a weapon
            let filteredWeapons = weapons.filter { $0.rarity == rarityValue }
            if let randomWeapon = filteredWeapons.randomElement() {
                return .weapon(randomWeapon)
            }
        } else {
            // 30% chance to get a fish
            let filteredFish = fishes.filter { $0.rarity == rarityValue }
            if let randomFish = filteredFish.randomElement() {
                return .fish(randomFish)
            }
        }
        return nil
    }
    
    func getRarity() -> RarityLevel? {
        let randomValue = Float.random(in: 0...1)
        print("Rarity: \(randomValue)")
        let modifier = Float(currentLevel)
        if randomValue <= (0.1 * modifier - max(0 , 0.05 * (modifier - 1))) {
            return .rare
        } else if randomValue > (0.1 * modifier - max(0 , 0.05 * (modifier - 1))) && randomValue <= (0.3 + 0.1 * (modifier)) {
            return .uncommon
        } else {
            return .common
        }
    }
}

