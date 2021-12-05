import SwiftUI
import Foundation

public struct ComboBoxList: View {
    @State private var query = ""
    @Binding var isPresented: Bool
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
    @Binding var choices: [String] {
        didSet {
            filteredChoices = choices
        }
    }
    
    @State private var filteredChoices: [String] = []
    
    @Binding var selectedItem: String
    
    var selectionBinding: Binding<String> {
        return Binding(get: {
            return selectedItem
        }, set: { value in
            updateSelection(withChoice: value)
        })
    }
    
    public var body: some View {
        Form {
            Section {
                HStack {
                    TextField("Search", text: queryBinding)
                    
                    Button("+", action: {
                        choices.append(query)
                    }).disabled(query.isEmpty || !choices.allSatisfy({ choice in
                        !choice.lowercased().contains(query.lowercased()) || !(choice.caseInsensitiveCompare(query) == .orderedSame) }))
                }
                
            }
            
            List {
                ForEach(filteredChoices, id: \.self) { choice in
                    ComboBoxRow(title: choice, selection: selectionBinding) {
                        updateSelection(withChoice: choice)
                    }
                }
            }
        }.onAppear {
            filteredChoices = choices
        }
    }
    
    func updateSelection(withChoice choice: String) {
        selectedItem = choice
    }
}


struct ComboBoxListPreview: PreviewProvider {
    static var previews: some View {
        ComboBoxList(isPresented: .constant(true), choices: .constant(["Hello", "World", "7"]), selectedItem: .constant(""))
    }
}
