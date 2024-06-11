//
//  GameFunction.swift
//  Nekoma
//
//  Created by Brendan Alexander Soendjojo on 08/06/24.
//

import Foundation

class StartGame: ObservableObject {
    var currentLevel: Int?
    var player: Cat?
    var enemies: [Enemy]?
    var chests: [Chest]?
    var weapons: [Weapon]?
    var fishes: [Fish]?

    init() {
        // Initialize game state
        self.initializeWeapons()
        self.initializeFishes()
        // Initialize player with starting values
        let startingWeapon = weapons!.first { $0.name == "Claw Mittens" }!
        self.player = Cat(lives: 9, baseAttack: 100, baseMovementSpeed: 20, currentWeapon: startingWeapon, storedWeapon: startingWeapon, cooldownLeft: 0)
        setupLevel()
    }
    
    func start() {
        // Logic to start the game
        print("Game started with player \(player!), enemies \(enemies!), and chests \(chests!) at level \(currentLevel!).")
    }

    func setupLevel() {
        // Spawning enemies and placing chests
        self.currentLevel = 5
        self.enemies = generateEnemies(level: currentLevel!)
        self.chests = generateChests(level: currentLevel!)
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
            Fish(id: 1, name: "Salmon", bonusLives: 0, bonusAttack: 0.1, bonusSpeed: 0, specialPower: SpecialPower(name: "Salmon Leap", cooldown: 100), rarity: .common),
            Fish(id: 2, name: "Salmon", bonusLives: 0, bonusAttack: 0.2, bonusSpeed: -2, specialPower: SpecialPower(name: "Salmon Leap", cooldown: 120), rarity: .uncommon),
            Fish(id: 3, name: "Salmon", bonusLives: 0, bonusAttack: 0.3, bonusSpeed: 0, specialPower: SpecialPower(name: "Salmon Leap", cooldown: 150), rarity: .rare),
            Fish(id: 4, name: "Sashimi", bonusLives: 1, bonusAttack: 0, bonusSpeed: 0, specialPower: SpecialPower(name: "Fresh Sashimi", cooldown: 100), rarity: .common),
            Fish(id: 5, name: "Sashimi", bonusLives: 2, bonusAttack: -0.1, bonusSpeed: -1, specialPower: SpecialPower(name: "Fresh Sashimi", cooldown: 120), rarity: .uncommon),
            Fish(id: 6, name: "Sashimi", bonusLives: 2, bonusAttack: 0, bonusSpeed: 0, specialPower: SpecialPower(name: "Fresh Sashimi", cooldown: 150), rarity: .rare),
            Fish(id: 7, name: "Tuna", bonusLives: 0, bonusAttack: 0, bonusSpeed: 2, specialPower: SpecialPower(name: "Tuna Terror", cooldown: 100), rarity: .common),
            Fish(id: 8, name: "Tuna", bonusLives: 0, bonusAttack: -0.2, bonusSpeed: 4, specialPower: SpecialPower(name: "Tuna Terror", cooldown: 120), rarity: .uncommon),
            Fish(id: 9, name: "Tuna", bonusLives: 0, bonusAttack: 0, bonusSpeed: 4, specialPower: SpecialPower(name: "Tuna Terror", cooldown: 150), rarity: .rare),
            Fish(id: 10, name: "Puffer Fish", bonusLives: 0, bonusAttack: 0.05, bonusSpeed: 1, specialPower: SpecialPower(name: "Invincibility", cooldown: 100), rarity: .common),
            Fish(id: 11, name: "Puffer Fish", bonusLives: 1, bonusAttack: 0.1, bonusSpeed: 2, specialPower: SpecialPower(name: "Invincibility", cooldown: 5), rarity: .uncommon),
            Fish(id: 12, name: "Puffer Fish", bonusLives: 2, bonusAttack: 0.2, bonusSpeed: 2, specialPower: SpecialPower(name: "Invincibility", cooldown: 150), rarity: .rare)
        ]
    }
    
    func generateEnemies(level: Int) -> [Enemy] {
        enemies = [
            Enemy(id: 1, name: .flea, type: .melee, range: 1.0, healthPoints: 50, attackSpeed: 1, movementSpeed: 10),
            Enemy(id: 2, name: .pig, type: .ranged, range: 5.0, healthPoints: 40, attackSpeed: 2, movementSpeed: 8)
        ]
        return enemies!
    }
    
    func generateChests(level: Int) -> [Chest] {
        let levelConfig: [Int: (roomsWithChest: Int, filledChests: Int, bossAppear: Bool)] = [
            1: (roomsWithChest: 4, filledChests: 2, bossAppear: false),
            2: (roomsWithChest: 5, filledChests: 2, bossAppear: false),
            3: (roomsWithChest: 6, filledChests: 3, bossAppear: false),
            4: (roomsWithChest: 7, filledChests: 3, bossAppear: false),
            5: (roomsWithChest: 7, filledChests: 4, bossAppear: true)
        ]
        
        guard let config = levelConfig[level] else {
            print("Level unavailable")
            return []
        }
        
        return distributeChests(roomsWithChest: config.roomsWithChest, filledChests: config.filledChests, bossAppear: config.bossAppear)
    }

    
    func distributeChests(roomsWithChest: Int, filledChests: Int, bossAppear: Bool) -> [Chest] {
        var chestPlacement: [Chest] = []
        var chestLeft: Int = filledChests
        var chestType: ChestType = .basic
        var chestContent: ChestContent?
        
        for roomNumber in 1...roomsWithChest {
            chestContent = nil
            if roomNumber == roomsWithChest {
                if bossAppear {
                    chestType = .special
                }
                chestContent = getChestContent(lastRoom: true)
                chestLeft -= 1
            } else if chestLeft > 1 {
                if roomNumber % 2 == 0 {
                    chestContent = getChestContent(lastRoom: false)
                    chestLeft -= 1
                }
            }
            print(chestLeft)
            chestPlacement.append(Chest(id: roomNumber, type: chestType, content: chestContent))
        }
        
        return chestPlacement
    }
    
    // 80% weapon - 20% fish
    func getChestContent(lastRoom: Bool) -> ChestContent? {
        let randomValue = Float.random(in: 0...1)
        print("Content: \(randomValue)")
        let rarityValue = getRarity()
        let chance: Float = {
            return lastRoom ? 0.1 : 0.8
        }()
        
        if randomValue <= chance {
            // 80% chance to get a weapon
            let filteredWeapons = weapons!.filter { $0.rarity == rarityValue }
            if let randomWeapon = filteredWeapons.randomElement() {
                return .weapon(randomWeapon)
            }
        } else {
            // 20% chance to get a fish
            let filteredFish = fishes!.filter { $0.rarity == rarityValue }
            if let randomFish = filteredFish.randomElement() {
                return .fish(randomFish)
            }
        }
        return nil
    }
    
    func getRarity() -> RarityLevel? {
        let randomValue = Float.random(in: 0...1)
        print("Rarity: \(randomValue)")
        let modifier = Float(currentLevel!)
        if randomValue <= (0.1 * modifier - max(0 , 0.05 * (modifier - 1))) {
            return .rare
        } else if randomValue > (0.1 * modifier - max(0 , 0.05 * (modifier - 1))) && randomValue <= (0.3 + 0.1 * (modifier)) {
            return .uncommon
        } else {
            return .common
        }
    }
}

