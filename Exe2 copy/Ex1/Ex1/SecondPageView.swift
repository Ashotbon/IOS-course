import SwiftUI

struct SecondPageView: View {
    let message: String

    var body: some View {
        Text(message)
            .navigationBarTitle("Screen2", displayMode: .inline)
    }
}
