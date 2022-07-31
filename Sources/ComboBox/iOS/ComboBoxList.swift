import SwiftUI
import Foundation

public struct ComboBoxList: View {
    @Environment(\.presentationMode) var presentationMode
    
    /// the query used to filter or add items
    @State private var query = ""
    
    /// binding used to help filter list.
    private var queryBinding: Binding<String> {
        Binding(get: {
            return query
        }, set: { queryValue in
            query = queryValue
            filteredChoices = !query.isEmpty ? choices.filter({ choice in
                choice.lowercased().contains(query.lowercased())
            }) : choices
        })
    }
    
    /// options for a user to choose from
    @Binding var choices: [String] {
        didSet {
            filteredChoices = choices
        }
    }
    
    /// filtered list
    @State private var filteredChoices: [String] = []
    
    /// the item selected from the list
    @Binding var selectedItem: String
    
    private var selectionBinding: Binding<String> {
        return Binding(get: {
            return selectedItem
        }, set: { value in
            updateSelection(withChoice: value)
        })
    }
    
    public var body: some View {
        Form {

            // separate Input field from the list
            Section {
                HStack {
                    TextField("Search", text: queryBinding)
                    
                    Button(action: {
                         choices.append(query)
                        
                        selectedItem = query
                        
                        presentationMode.wrappedValue.dismiss()
                     }, label: {
                         Image(systemName: "plus")
                     }).disabled(query.isEmpty || !choices.allSatisfy({ choice in
                        !choice.lowercased().contains(query.lowercased()) || !(choice.caseInsensitiveCompare(query) == .orderedSame) }))
                }
                
            }
            
            List {
                ForEach(filteredChoices, id: \.self) { choice in
                    ComboBoxRow(title: choice, selection: selectionBinding) {
                        updateSelection(withChoice: choice)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }.onAppear {
            // make sure filteredChoices is not empty
            filteredChoices = choices
        }
    }
    
    func updateSelection(withChoice choice: String) {
        selectedItem = choice
    }
}


struct ComboBoxListPreview: PreviewProvider {
    static var previews: some View {
        ComboBoxList(choices: .constant(["Hello", "World", "7"]), selectedItem: .constant(""))
    }
}
