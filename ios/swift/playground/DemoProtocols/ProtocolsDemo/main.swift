protocol CanFly {
    func fly()
}

class Bird {
    
    var isFemale = true
    
    func layEgg() {
        if isFemale {
            print("laying eggs")
        }
    }
}

class Eagle: Bird, CanFly {
    func fly() {
        print("Eagle flying")
    }
    
    func soar() {
        print("I can soar")
    }
}

class Penguin: Bird {
    func swim() {
        print("I can swim")
    }
}

struct FlyingMuseum {
    func flyingDemo(flyingObject: CanFly) {
        flyingObject.fly()
    }
}

struct Airplane: CanFly {
    func fly() {
        print("Plane is flying")
    }
}

let myEagle = Eagle()
myEagle.fly()
myEagle.layEgg()
myEagle.soar()

let myPenguin = Penguin()
myEagle.layEgg()
myEagle.soar()
myEagle.fly() // shouldn't be able to do this

let myPlane = Airplane()

let museum = FlyingMuseum()
museum.flyingDemo(flyingObject: myPlane)
