import SwiftUI

struct ComboBox: View {
    @State private var query = ""
    @Binding var choices: [String]
    
    var body: some View {
        TextField("Search", text: $query)
    }
}


struct ComboBoxPreview: PreviewProvider {
    static var previews: some View {
        ComboBox(choices: .constant(["Hello", "World", "7"]))
    }
}
