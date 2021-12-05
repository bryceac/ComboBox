//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/3/21.
//

import SwiftUI

/// view that represents a row in a ComboBox
public struct ComboBoxRow: View {
    
    /// the view's textual value
    var title: String
    
    /// the selected item in the list
    @Binding var selection: String
    
    /// a closure that will run when a button is clicked
    var action: ()-> Void
    
    /// computed property to determine if a given item was selected.
    var isSelected: Bool {
        return selection.caseInsensitiveCompare(title) == .orderedSame
    }
    
    public var body: some View {
        HStack {
            Button(title, action: self.action)
            if isSelected {
                Spacer()
                Image(systemName: "checkmark").foregroundColor(.blue)
            }
        }
    }
}

struct ComboBoxRow_Previews: PreviewProvider {
    static var previews: some View {
        ComboBoxRow(title: "Hello", selection: .constant(""), action: {})
    }
}
