//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/4/21.
//

import SwiftUI

/// View that allows things to be selected, like a Picker, but also allows the user to customize the list.
public struct ComboBox: View {
    
    /// options a user can choose from
    @Binding var choices: [String]
    
    /// the currently selected value
    @Binding var value: String
    
    
    /** the number of items to display.
     This property is only used on macOS and is ignored otherwise.
        */
    var numberOfItemsDisplayed: Int = 5
    
    public var body: some View {
        // set up a navigation view, so that view will work like a normal picker in forms.
        
        #if os(iOS)
        NavigationLink(destination: ComboBoxList(choices: $choices, selectedItem: $value)) {
            Text(value)
        }
        #else
        macComboBox(content: $choices, selectedItem: $value)
        #endif
    }
    
    /**
     create a ComboBox view.
     - Parameters:
        - parameter choices: the starting choices for the combobox.
        - parameter value: the default value of the picker.
        - parameter itemsToDisplay: The number of items shown at a time.
     - Returns: ComboBox object
     */
    public init(choices: Binding<[String]>, value: Binding<String>, itemsToDisplay numberOfItemsDisplayed: Int = 5) {
        self._choices = choices
        self._value = value
        self.numberOfItemsDisplayed = numberOfItemsDisplayed
    }
}

struct ComboBox_Previews: PreviewProvider {
    static var previews: some View {
        ComboBox(choices: .constant(["Hello", "World", "7"]), value: .constant("Hello"))
    }
}
