//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/5/21.
//

import SwiftUI
import AppKit
import Foundation

struct macComboBox: NSViewRepresentable {
    typealias NSViewType = NSComboBox
    
    @Binding var content: [String]
    var numberOfVisibleItems: Int = 5
    @Binding var selectedItem: String
    
    var selectedItemIndex: Int? {
        get {
            guard let index = content.firstIndex(of: slectedItem) else { return nil }
            
            return index
        }
        
        set {
            selectedItem = content[newValue]
        }
    }
    
    final class Coordinator: NSObject, NSComboBoxDelegate, NSComboBoxDataSource {
        
        var parent: macComboBox
        
        init(_ parent: macComboBox) {
            self.parent = parent
        }
        
        func comboBoxSelectionDidChange(_ notification: Notification) {
            guard let combo = notification.object as? NSComboBox, parent.selectedItemIndex != combo.indexOfSelectedItem else { return }
            
            parent.selectedItemIndex = combo.indexOfSelectedItem
        }
        
        func comboBox(_ comboBox: NSComboBox, indexOfItemWithStringValue string: String) -> Int {
            
            var itemIndex: Int = 0
            
            if let index = items.firstIndex(of: string) {
                itemIndex = index
            } else {
                comboBox.addItem(withObjectValue: string)
                
                comboBox.reloadData()
                
                itemIndex = items.firstIndex(of: string)!
            }
            
            return itemIndex
        }
        
        func comboBox(_ comboBox: NSComboBox, completedString string: String) -> String? {
            guard let index = parent.content.firstIndex(where: { option in
                
                option.lowercased().contains(string.lowercased() ||
                option.caseInsensitiveCompare(string) == .orderedSame })
            }) else { return nil }
            
            return parent.content[index]
        }
        
        func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
            parent.content[index]
        }
        
        func numberOfItems(in comboBox: NSComboBox) -> Int {
            return parent.content.count
        }
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeNSView(context: NSViewRepresentableContext<macComboBox>) -> NSComboBox {
        let combo = NSComboBox()
        combo.numberOfVisibleItems = numberOfVisibleItems
        combo.hasVerticalScroller = true
        combo.completes = true
        combo.usesDataSource = true
        combo.dataSource = context.coordinator
        combo.delegate = context.coordinator
        combo.addItems(withObjectValues: content)
        combo.stringValue = selectedItem
        combo.reloadData()
        return combo
    }
    
    /* func updateNSView(_ nsView: NSComboBox, context: NSViewRepresentableContext<macComboBox>) {
        guard selectedIndex != nsView.indexOfSelectedItem else { return }
        
        DispatchQueue.main.async {
            nsView.selectItem(at: selectedIndex)
        }
    } */
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        macComboBox(content: .constant(["Hello", "World", "7"]), numberOfVisibleItems: 5, selectedIndex: 0)
    }
}
