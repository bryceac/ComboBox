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
    @State var choices: [String] = []
    @State private var filteredChoices: [String] = []
    
    @State private var selectedItemIndex: Int = 0
    
    var body: some View {
        Form {
            Section {
                HStack {
                    TextField("Search", text: queryBinding)
                    
                    Button("+", action: {
                        choices.append(query)
                    }).disabled(choices.allSatisfy({ choice in
                        !choice.lowercased().contains(query.lowercased()) || !(choice.caseInsensitiveCompare(query) == .orderedSame) }))
                }
                
            }
            
            List {
                ForEach(filteredChoices, id: \.self) { choice in
                    ComboBoxRow(title: choice, selection: choices[selectedItemIndex]) {
                        guard let choiceIndex = choices.firstIndex(of: choice) else { return }
                        selectedItemIndex = choiceIndex
                    }
                }
            }
        }.onAppear {
            filteredChoices = choices
        }
    }
}


struct ComboBoxListPreview: PreviewProvider {
    static var previews: some View {
        ComboBoxList(choices: ["Hello", "World", "7"])
    }
}
