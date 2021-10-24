import SwiftUI

struct DogView: View {
    var dog: Dog
    
    var body: some View {
        let text = Text("\(dog.name) is a \(dog.breed)")
        if dog.selected {
            text.bold()
        } else {
            text
        }
    }
}

struct ContentView: View {
    // Adding the @ObservedObject property wrapper subscribes to changes.
    @ObservedObject var model: Model // Selecting a dog mutates this.
    
    var body: some View {
        VStack {
            Text("Dogs (\(model.dogs.count))").font(.title).padding()
            VStack(alignment: .leading) {
                ForEach(model.dogs) { dog in
                    DogView(dog: dog).onTapGesture {
                        model.toggle(dog)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = Model()
        ContentView(model: model)
    }
}
