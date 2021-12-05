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
    
    @Binding var content: [String]
    var numberOfVisibleItems: Int
    @State var selectedIndex: Int
    
    var selectedItem: String {
        return content[selectedIndex]
    }
    
    final class Coordinator: NSObject, NSComboBoxDelegate {
        
        @Binding var selected: Int
        
        init(selected: Binding<Int>) {
            self._selected = selected
        }
        
        func comboBoxSelectionDidChange(_ notification: Notification) {
            guard let combo = notification.object as? NSComboBox, selected != combo.indexOfSelectedItem else { return }
            
            selected = combo.indexOfSelectedItem
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(selected: $selectedIndex)
    }
    
    func makeNSView(context: NSViewRepresentableContext<macComboBox>) -> NSComboBox {
        let combo = NSComboBox()
        combo.numberOfVisibleItems = numberOfVisibleItems
        combo.hasVerticalScroller = true
        combo.usesDataSource = false
        combo.delegate = context.coordinator
        
        for choice in content {
            combo.addItem(withObjectValue: choice)
        }
        
        return combo
    }
    
    func updateNSView(_ nsView: NSComboBox, context: NSViewRepresentableContext<macComboBox>) {
        guard selectedIndex != nsView.indexOfSelectedItem else { return }
        
        DispatchQueue.main.async {
            nsView.selectItem(at: selectedIndex)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        macComboBox(content: .constant(["Hello", "World", "7"]), numberOfVisibleItems: 5, selectedIndex: 0)
    }
}
