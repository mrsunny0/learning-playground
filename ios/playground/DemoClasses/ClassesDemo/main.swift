let enemy = Enemy()
enemy.move()
enemy.attack()

let dragon = Boss()
dragon.bossAttack()

dragon.takeDamage(damage: 50)
print(dragon.health)
