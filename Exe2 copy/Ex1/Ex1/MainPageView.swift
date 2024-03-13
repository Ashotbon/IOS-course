
import SwiftUI

struct MainPageView: View {
    @State private var inputText: String = ""
    @State private var outputText: String = ""
    @State private var navigateToSecondPage = false
    @State private var showAlert = false
    @State private var showError = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Enter text here", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if showError {
                    Text("The input field should not be empty!")
                        .foregroundColor(.red)
                }

                Button("Say Hello with UILabel") {
                    if !inputText.isEmpty {
                        outputText = "Hello \(inputText)"
                        showError = false
                    } else {
                        showError = true
                    }
                }
                .buttonStyle(.bordered)

                Button("Say hello with VS(separate view)") {
                    if !inputText.isEmpty {
                        navigateToSecondPage = true
                        showError = false
                        outputText=""
                        inputText=""
                    } else {
                        showError = true
                    }
                }
                .buttonStyle(.borderedProminent)

                Button("Say hello with dialog box (Alert)") {
                    if !inputText.isEmpty {
                        showAlert = true
                        showError = false
                    } else {
                        showError = true
                    }
                }
                .buttonStyle(.bordered)
                .alert("Hello", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Hello \(inputText)")
                }

                if !outputText.isEmpty {
                    Text(outputText)
                        .padding()
                }
            }
            .navigationTitle("Screen1")
            .navigationDestination(isPresented: $navigateToSecondPage) {
                SecondPageView(message: "Hello \(inputText)")
            }
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
