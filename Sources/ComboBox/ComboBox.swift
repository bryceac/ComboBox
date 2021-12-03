import SwiftUI

struct ComboBox: View {
    @State private var query = ""
    @State var choices: [String] = []
    
    var body: some View {
        TextField("Search", text: $query)
    }
}


struct ComboBoxPreview: PreviewProvider {
    static var previews: some View {
        ComboBox(choices: ["Hello", "World", "7"])
    }
}
