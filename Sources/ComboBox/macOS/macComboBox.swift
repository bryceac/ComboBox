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
            guard let combo = notification.object as? NSComboBox, selected.wrappedValue != combo[combo.indexOfSelectedItem] else { return }
            
            selected.wrappedValue = combo[combo.indexOfSelectedItem]
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
        guard selected != nsView[nsView.indexOfSelectedItem], let selectedItemIndex = nsView.indexOfItem(withObjectValue: selected) else { return }
        
        DispatchQueue.main.async {
            nsView.selectItem(at: selectedItemIndex)
        }
    }
    
    
}

struct macComboBox_Previews: PreviewProvider {
    static var previews: some View {
        macComboBox()
    }
}
