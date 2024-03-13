import SwiftUI

struct SecondView: View {
    let message: String
    var databaseManager: DatabaseManager
    
    var body: some View {
        Text(message)
            .navigationBarTitle("Screen2", displayMode: .inline)
        Button("Fetch Data") {
                        databaseManager.fetchData()
                    }
        Button("Delete Data") {
                        databaseManager.deleteAllData()
                    }
    }
}
