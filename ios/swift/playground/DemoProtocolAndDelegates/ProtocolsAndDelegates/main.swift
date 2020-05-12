protocol AdvancedLifeSupport {
    func performCPR()
}

class EmergencyCallHandler {
    var delegate: AdvancedLifeSupport?

    func assessSituation() {
        print("Assessing")
    }
    
    func medicalEmergency() {
        delegate?.performCPR()
    }

}

struct Paramedic: AdvancedLifeSupport {
    func performCPR() {
        print("I now how to perform CPR")
    }
    
    // set up delegate pattern
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
}

class Doctor: AdvancedLifeSupport {
    func performCPR() {
        print("Doctor is doing something here")
    }
    
    func useStethescope() {
        print("Doing doctor things")
    }
    
    // set up delegate pattern
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
}

// this alrady contains the functions of AdvancedLifeSupport
class Surgeon: Doctor {
    override func performCPR() {
        print("I am a surgeon doing stuff")
    }
    
    // delegate pattern init call is already there
}

let emilio = EmergencyCallHandler()
let pete = Doctor(handler: emilio) // emilio is given the delegate pete

emilio.assessSituation()
emilio.medicalEmergency() // this does the 'callback" which is pete's function call
