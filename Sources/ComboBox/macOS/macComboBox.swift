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
    var numberOfVisibleItems: Int
    @Binding var selectedItem: String
    
    var selectedItemIndex: Int? {
        guard let index = content.firstIndex(of: slectedItem) else { return nil }
        
        return index
    }
    
    var selectedItem: String {
        return content[selectedIndex]
    }
    
    final class Coordinator: NSObject, NSComboBoxDelegate, NSComboBoxDataSource {
        
        @Binding var selected: Int
        @Binding var items: [String]
        
        init(items: Binding<[String]>, selected: Binding<Int>) {
            self._items = items
            self._selected = selected
        }
        
        func comboBoxSelectionDidChange(_ notification: Notification) {
            guard let combo = notification.object as? NSComboBox, selected != combo.indexOfSelectedItem else { return }
            
            selected = combo.indexOfSelectedItem
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
            guard let index = items.firstIndex(where: { option in
                
                option.lowercased().contains(string.lowercased() ||
                option.caseInsensitiveCompare(string) == .orderedSame })
            }) else { return nil }
            
            return items[index]
        }
        
        func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
            items[index]
        }
        
        func numberOfItems(in comboBox: NSComboBox) -> Int {
            return items.count
        }
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(items: $content, selected: $selectedIndex)
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
