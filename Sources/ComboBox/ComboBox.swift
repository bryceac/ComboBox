//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/4/21.
//

import SwiftUI
import Foundation

/// View that allows things to be selected, like a Picker, but also allows the user to customize the list.
public struct ComboBox: View {
    
    /// options a user can choose from
    @Binding var choices: [String]
    
    /// the currently selected value
    @Binding var value: String
    
    private var valueBinding: Binding<String> {
        Binding(get: {
            return value
        }, set: { itemValue in
            if !choices.contains(where: { choice in
                choice.lowercased().contains(itemValue.lowercased()) || choice.caseInsensitiveCompare(itemValue) == .orderedSame
            }) {
                choices.append(itemValue)
            }
            
            value = itemValue
        })
    }
    
    public var body: some View {
        // set up a navigation view, so that view will work like a normal picker in forms.
        
        #if os(iOS)
        NavigationView {
            NavigationLink(destination: ComboBoxList(choices: $choices, selectedItem: $value)) {
                Text(value)
            }
        }
        #else
        macComboBox(content: $choices, selectedItem: valueBinding)
        #endif
    }
    
    /**
     create a ComboBox view.
     - Parameters:
        - parameter choices: the starting choices for the combobox.
        - parameter value: the default value of the picker.
     - Returns: ComboBox object
     */
    public init(choices: Binding<[String]>, value: Binding<String>) {
        self._choices = choices
        self._value = value
    }
}

struct ComboBox_Previews: PreviewProvider {
    static var previews: some View {
        ComboBox(choices: .constant(["Hello", "World", "7"]), value: .constant("Hello"))
    }
}
