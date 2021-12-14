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
    var numberOfVisibleItems: Int = 5
    @Binding var selectedItem: String {
        willSet {
            guard !content.contains(where: { option in
                option.lowercased().contains(newValue) || option.caseInsensitiveCompare(newValue) == .orderedSame
            }) else { return }
            
            content.append(newValue)
        }
    }
    
    final class Coordinator: NSObject, NSComboBoxDelegate, NSComboBoxDataSource {
        
        var parent: macComboBox
        
        init(_ parent: macComboBox) {
            self.parent = parent
        }
        
        func comboBoxSelectionDidChange(_ notification: Notification) {
            guard let combo = notification.object as? NSComboBox else { return }
            
            DispatchQueue.main.async {
                self.parent.selectedItem = combo.stringValue
            }
        }
        
        func comboBox(_ comboBox: NSComboBox, indexOfItemWithStringValue string: String) -> Int {
            
            guard let index = parent.content.firstIndex(of: string) else { return -1 }
            
            return index
        }
        
        func comboBox(_ comboBox: NSComboBox, completedString string: String) -> String? {
            guard let index = parent.content.firstIndex(where: { option in
                
                option.lowercased().contains(string.lowercased()) ||
                option.caseInsensitiveCompare(string) == .orderedSame
            }) else { return nil }
            
            return parent.content[index]
        }
        
        func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
            parent.content[index]
        }
        
        func numberOfItems(in comboBox: NSComboBox) -> Int {
            return parent.content.count
        }
        
        func controlTextDidEndEditing(_ obj: Notification) {
            guard let combo = obj as? NSComboBox else { return }
            
            DispatchQueue.main.async {
                self.parent.selectedItem = combo.stringValue
            }
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
        combo.stringValue = selectedItem
        combo.reloadData()
        return combo
    }
    
    func updateNSView(_ nsView: NSComboBox, context: NSViewRepresentableContext<macComboBox>) {}
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        macComboBox(content: .constant(["Hello", "World", "7"]), selectedItem: .constant("Hello"))
    }
}
