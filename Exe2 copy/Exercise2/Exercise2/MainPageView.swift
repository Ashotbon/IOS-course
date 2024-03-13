/*import SwiftUI

struct MainPageView: View {
    @State private var inputText: String = ""
    @State private var outputText: String = ""
    @State private var navigateToSecondPage = false
    @State private var sliderValue: Double = 24
    @State private var selectedOption: String = "Don't want to say"
    @State private var selectedPets: [String] = []
    @State private var showError = false
    @State private var shouldNavigate: Bool = false
    @State private var isEditing: Bool = false
    let petsList = ["Dogs", "Cats", "Birds", "Fish"]
    let optionsRadioButtion = ["Asia", "Africa", "North America", "South America","Antarctica"," Europe","Australia"]


     var body: some View {
         let databaseManager = DatabaseManager()
         
         NavigationStack {
             VStack(spacing: 20) {
                 Text("What is your name 2-20 chars")
                
                 TextField("Enter text here", text: $inputText)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .padding()
                 
                 
                 if showError {
                     Text("The input f name 2-20 chars")
                         .foregroundColor(.red)
                 }
                       Text ("What is your age range?")
                 Form {
                     Picker("What is your age range?", selection: $selectedOption) {
                         Text("less than 18").tag("less than 18")
                         Text("18 to 64").tag("18 to 64")
                         Text("65 or more").tag("65 or more")
                         Text("Don't want to say").tag("Don't want to say")
                     }
                     .pickerStyle(SegmentedPickerStyle())
                 }

                 
                 
                 Text("Choose your continent of residence")
                 
                 
                 Picker("Options", selection: $selectedOption) {
                                    ForEach(optionsRadioButtion, id: \.self) { option in
                                        Text(option).tag(option)
                                    }
                                }
                 .pickerStyle(.wheel)
                 Text("What pets do you like?")
        

                 LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                     ForEach(petsList, id: \.self) { pet in
                         HStack {
                             Image(systemName: selectedPets.contains(pet) ? "checkmark.square" : "square")
                             Text(pet)
                                 .frame(width: 40, alignment: .leading)
                         }
                         .onTapGesture {
                             if selectedPets.contains(pet) {
                                 selectedPets.removeAll { $0 == pet }
                             } else {
                                 selectedPets.append(pet)
                             }
                         }
                     }
                }
              
                 
                 Text("What is your preferred temperature[C]?")

                 HStack {
                     
                     Slider(value: $sliderValue, in: 18...32, step: 1) { editing in
                         isEditing = editing
                     }
                     Text("\(Int(sliderValue))")
                 }
                 .padding()
               
                 Button("Add my Info(plist txt csv) and show full in next VC") {
                    if ( inputText.count >= 2 && inputText.count <= 20) {
                        showError = false
                        shouldNavigate = true
                        
                    } else {
                        showError = true
                        shouldNavigate = false
                     }
                  
                 
                     databaseManager.insertData(ageRange: "65", pets: "dog")
                }.buttonStyle(.bordered)
                     .border(Color.blue, width: 1) // Set the border color and width
                     .padding()

             
            }
             .navigationDestination(isPresented: $shouldNavigate) {
                 SecondView(message: "Hello", databaseManager: databaseManager)
             }
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
*/
import SwiftUI

struct MainPageView: View {
    
    let databaseManager = DatabaseManager()
    @State private var inputText: String = ""
    @State private var sliderValue: Double = 24
    @State private var selectedAgeRange: String = "Don't want to say"
    @State private var selectedContinent: String = "North America"
    @State private var selectedPets: [String] = []
    @State private var showError = false
    @State private var shouldNavigate: Bool = false
    @State private var isEditing: Bool = false
    
    let ageRanges = ["less than 18", "18 to 64", "65 or more", "Don't want to say"]
    let continents = ["Asia", "Africa", "North America", "South America", "Antarctica", "Europe", "Australia"]
    let petsList = ["Dogs", "Cats", "Birds", "Fish"]

    var body: some View {
        
        NavigationStack {
            VStack(spacing: 20) {
                Text("What is your name? (2-20 characters)")
                
                TextField("Enter text here", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if showError {
                    Text("The input for name must be 2-20 characters")
                        .foregroundColor(.red)
                }
                
                Text("What is your age range?")
                VStack {
                    ForEach(ageRanges, id: \.self) { ageRange in
                        HStack {
                            Text(ageRange)
                            Spacer()
                            Image(systemName: selectedAgeRange == ageRange ? "largecircle.fill.circle" : "circle")
                                .onTapGesture {
                                    selectedAgeRange = ageRange
                                }
                        }
                        .padding(.horizontal)
                    }
                }
                
                Text("Choose your continent of residence")
                Picker("Continent", selection: $selectedContinent) {
                    ForEach(continents, id: \.self) {
                        Text($0).tag($0)
                    }
                }
                .pickerStyle(.wheel)
                
                Text("What pets do you like?")
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(petsList, id: \.self) { pet in
                        HStack {
                            Image(systemName: selectedPets.contains(pet) ? "checkmark.square" : "square")
                            Text(pet)
                        }
                        .onTapGesture {
                            if selectedPets.contains(pet) {
                                selectedPets.removeAll { $0 == pet }
                            } else {
                                selectedPets.append(pet)
                            }
                        }
                    }
                }
                Text("Preferred temperature [C]: \(Int(sliderValue))")
                HStack {
                   
                    Slider(value: $sliderValue, in: 18...32, step: 1)
                }
                .padding()
                
                Button("Add my information and show full list") {
                    if inputText.count >= 2 && inputText.count <= 20 {
                        showError = false
                        shouldNavigate = true
                    } else {
                        showError = true
                        shouldNavigate = false
                    }
                 
                    databaseManager.insertData(name:inputText,ageRange:selectedAgeRange, continent:selectedContinent, temp:sliderValue, pets:selectedPets)
                }
                .buttonStyle(.bordered)
                .border(Color.blue, width: 1)
                .padding()
            }
            .navigationDestination(isPresented: $shouldNavigate) {
                // The destination view will need to accept and display the entered data
                // Assuming SecondView exists and can display the information
                SecondView(message: "Data entered", databaseManager: DatabaseManager())
            }
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}

