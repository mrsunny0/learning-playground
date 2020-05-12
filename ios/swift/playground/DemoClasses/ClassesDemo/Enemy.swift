class Enemy {
    var health = 100
    var attackStrength = 50
    
    func move() {
        print("Moving")
    }
    
    func attack() {
        print("Attacking with damage \(attackStrength)")
    }
    
    func takeDamage(damage: Int) {
        self.health -= damage
    }
}


