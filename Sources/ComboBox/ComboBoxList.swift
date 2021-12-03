import SwiftUI
import Foundation

struct ComboBoxList: View {
    @State private var query = ""
    var queryBinding: Binding<String> {
        Binding(get: {
            return query
        }, set: { queryValue in
            query = queryValue
            filteredChoices = !query.isEmpty ? choices.filter({ choice in
                choice.lowercased().contains(query.lowercased())
            }) : choices
        })
    }
    var choices: [String] = []
    @State private var filteredChoices: [String] = []
    
    var body: some View {
        Form {
            Section {
                TextField("Search", text: $query)
            }
            
            List {
                ForEach(choices, id: \.self) { choice in
                    Text(choice)
                }
            }
        }
        
    }
}


struct ComboBoxListPreview: PreviewProvider {
    static var previews: some View {
        ComboBoListx(choices: ["Hello", "World", "7"])
    }
}
