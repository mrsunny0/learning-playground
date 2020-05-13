let myOptional: String?

myOptional = "George"

// force unwrap
var text: String = myOptional!

// check for nil values
if myOptional != nil {
    text = myOptional!
}

// optional binding
// use another variable to escape the optional if nil
if let safeOptional = myOptional {
    text = safeOptional
}

// nil coalescing operator
let newText: String = myOptional ?? "Default value"
print(newText)

// optional chaining
struct MyStruct {
    var property = 23
    func method() {
        print("I am a struct")
    }
}

let myStruct: MyStruct?

myStruct = nil
print(myStruct?.property)
