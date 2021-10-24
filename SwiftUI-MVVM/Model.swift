import Foundation
import os.log

struct Dog: CustomStringConvertible, Identifiable {
    var description: String { "Dog: \(name) \(selected)" } // required by CustomStringConvertible
    private static var lastId = 0;
    
    var selected = false
    var id: Int
    var breed: String
    var name: String
    
    init(name: String, breed: String) {
        Dog.lastId += 1
        id = Dog.lastId
        self.name = name
        self.breed = breed
    }
}

// This must be a class instead of a struct
// in order to conform to the ObservableObject protocol.
// Things that do this gain an objectWillChange method that publishes changes.
// This can be called directly before changes are made.
// Alternatively, if the properties that can be changed are annotated with
// the @Published property wrapper, changes will be published automatically.
class Model: ObservableObject {
    // The @Published property wrapper causes changes to be published.
    @Published var dogs: [Dog] = []
    //private let logger = Logger()
    
    init() {
        dogs.append(Dog(name: "Maisey", breed: "Treeing Walker Coonhound"))
        dogs.append(Dog(name: "Ramsay", breed: "Native American Indian Dog"))
        dogs.append(Dog(name: "Oscar", breed: "German Shorthaired Pointer"))
        dogs.append(Dog(name: "Comet", breed: "Whippet"))
    }
    
    //mutating func select(_ dog: Dog) {
    func toggle(_ dog: Dog) {
        // This is not needed if properties have the @Published annotation.
        //objectWillChange.send() // notifies subscribers
        
        // Can't use the first method to find the matching Dog
        // because that would return a copy of the Dog struct.
        // We need to be able to modify the struct in the array, not a copy.
        let index = dogs.firstIndex(where: { $0.id == dog.id })
        if let index = index {
            dogs[index].selected.toggle()
            let msg = "Model.select: selectedDog = \(String(describing: dogs[index]))"
            print(msg)
            //logger.debug(OSLogMessage(stringLiteral: msg))
            print(dogs)
        }
    }
}
