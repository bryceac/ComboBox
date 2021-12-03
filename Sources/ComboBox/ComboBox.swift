import SwiftUI
import Foundation

struct ComboBox: View {
    @State private var query = ""
    var queryBinding: Binding<String> {
        Binding(get: {
            return query
        }, set: { queryValue in
            filteredChoices = !query.isEmpty ? choices.filter({ choice in
                choice.lowercased().contains(query.lowercased())
            }) : choices
        })
    }
    var choices: [String] = []
    @State private var filteredChoices: [String] = []
    
    var body: some View {
        Form {
            TextField("Search", text: $query)
            
            List {
                ForEach(choices, id: \.self) { choice in
                    Text(choice)
                }
            }
        }
        
    }
}


struct ComboBoxPreview: PreviewProvider {
    static var previews: some View {
        ComboBox(choices: ["Hello", "World", "7"])
    }
}
