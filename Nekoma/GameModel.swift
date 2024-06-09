//
//  GameModel.swift
//  Nekoma
//
//  Created by Brendan Alexander Soendjojo on 08/06/24.
//

enum AttackType: String {
    case melee = "Melee"
    case ranged = "Ranged"
}

enum EnemyName: String {
    case rat = "Rat"
    case flea = "Flea"
}

enum RarityLevel: String {
    case common = "Common"
    case uncommon = "Uncommon"
    case rare = "Rare"
}

enum ChestType: String {
    case common = "Common"
    case special = "Special"
}

enum ChestContent {
    case weapon(Weapon)
    case fish(Fish)
}

class Cat {
    let lives: Int
    let attack: Float
    let movementSpeed: Int
    let currentWeapon: Weapon
    let storedWeapon: Weapon?
    let cooldownLeft: Float
    
    init(lives: Int, baseAttack: Float, baseMovementSpeed: Int, currentWeapon: Weapon, storedWeapon: Weapon, cooldownLeft: Float) {
        self.lives = lives
        self.attack = baseAttack
        self.movementSpeed = baseMovementSpeed
        self.currentWeapon = currentWeapon
        self.storedWeapon = storedWeapon
        self.cooldownLeft = cooldownLeft
    }
}

class Enemies {
    let id: Int
    let name: EnemyName
    let type: AttackType
    let range: Float
    let healthPoints: Int
    let attackSpeed: Int
    let movementSpeed: Int // constant
    
    init(id: Int, name: EnemyName, type: AttackType, range: Float, healthPoints: Int, attackSpeed: Int, movementSpeed: Int) {
        self.id = id
        self.name = name
        self.type = type
        self.range = range
        self.healthPoints = healthPoints
        self.attackSpeed = attackSpeed
        self.movementSpeed = movementSpeed
    }
}

struct Weapon {
    let id: Int
    let name: String
    let type: AttackType
    let minDamage: Int
    let maxDamage: Int
    let attackSpeed: Float
    let range: Int
    let rarity: RarityLevel
}

struct Fish {
    let id: Int
    let name: String
    let bonusLives: Int
    let bonusAttack: Float
    let bonusSpeed: Float
    let specialPower: SpecialPower
    let rarity: RarityLevel
}

struct SpecialPower {
    let name: String
    let cooldown: Float
    // What the power does is not yet defined
}

struct Chest {
    let id: Int
    let type: ChestType
    let content: ChestContent?
}


