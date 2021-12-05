//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/5/21.
//

import SwiftUI
import AppKit

struct macComboBox: NSViewRepresentable {
    typealias NSViewType = NSComboBox
    
    var content: [String]
    var numberOfVisibleItems: Int
    
    @Binding var selected: String
    
    final class Coordinator: NSObject, NSComboBoxDelegate {
        var selected: Binding<String>
        
        init(selected: Binding<String>) {
            self.selected = selected
        }
        
        func comboBoxSelectionDidChange(_ notification: Notification) {
            guard let combo = notification.object as? NSComboBox,
                  let currentItem = combo.objectValues[combo.indexOfSelectedItem] as? String,selected.wrappedValue != currentItem else { return }
            
            selected.wrappedValue = currentItem
        }
    }
    
    func makeCoordinator() -> macComboBox.Coordinator {
        Coordinator(selected: $selected)
    }
    
    func makeNSView(context: NSViewRepresentableContext<macComboBox>) -> NSComboBox {
        let comboBox = NSComboBox()
        comboBox.numberOfVisibleItems = numberOfVisibleItems
        comboBox.usesDataSource = false
        comboBox.delegate = context.coordinator
        
        for choice in content {
            comboBox.addItem(withObjectValue: choice)
        }
        
        return comboBox
    }
    
    func updateNSView(_ nsView: NSComboBox, context: NSViewRepresentableContext<macComboBox>) {
        guard let currentItem = nsView.objectValues[nsView.indexOfSelectedItem] as? String,selected != currentItem else { return }
        
        let selectedItemIndex = nsView.indexOfItem(withObjectValue: selected)
        
        DispatchQueue.main.async {
            nsView.selectItem(at: selectedItemIndex)
        }
    }
    
    
}

struct macComboBox_Previews: PreviewProvider {
    static var previews: some View {
        macComboBox(content: ["Hello", "World", "7"], numberOfVisibleItems: 5, selected: .constant("Hello"))
    }
}
