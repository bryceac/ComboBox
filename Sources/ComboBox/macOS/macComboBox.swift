//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/5/21.
//

#if os(macOS)
import SwiftUI
import AppKit

/// View type that respresents an NSComboBox
struct macComboBox: NSViewRepresentable {
    typealias NSViewType = NSComboBox
    
    /// the choices available to select from
    @Binding var content: [String]

    var numberOfVisibleItems: Int = 5

    /// the string value of the selection
    @Binding var selectedItem: String {
        willSet {
            // make sure item is added to choices when necessary.
            guard !newValue.isEmpty && !content.contains(where: { option in
                option.lowercased().contains(newValue) || option.caseInsensitiveCompare(newValue) == .orderedSame
            }) else { return }
            
            content.append(newValue)
        }
    }
    
    /// type that is used to communicate with underlying NSComboBox
    final class Coordinator: NSObject, NSComboBoxDelegate, NSComboBoxDataSource {
        
        // bring in parent view, to make assignment easier
        var parent: macComboBox
        
        init(_ parent: macComboBox) {
            self.parent = parent
        }
        
        // implement function necessary to update the selection correctly.
        func comboBoxSelectionDidChange(_ notification: Notification) {
            guard let combo = notification.object as? NSComboBox else { return }
            
            // update selected item value in background, so that changes will be reflected.
            DispatchQueue.main.async {
                self.parent.selectedItem = combo.stringValue
            }
        }
        
        // implement function necessary to get index of items
        func comboBox(_ comboBox: NSComboBox, indexOfItemWithStringValue string: String) -> Int {
            
            guard let index = parent.content.firstIndex(of: string) else { return -1 }
            
            return index
        }
        
        // implement function used for autocompletion.
        func comboBox(_ comboBox: NSComboBox, completedString string: String) -> String? {

            // make sure input is matched regardless of case and if string is complete or not.
            guard let index = parent.content.firstIndex(where: { option in
                
                option.lowercased().contains(string.lowercased()) ||
                option.caseInsensitiveCompare(string) == .orderedSame
            }) else { return nil }
            
            return parent.content[index]
        }
        
        // implement function necessary to grab values from data source.
        func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
            parent.content[index]
        }
        
        // implement function to specify how many items are in the data source.
        func numberOfItems(in comboBox: NSComboBox) -> Int {
            return parent.content.count
        }
        
        // implement function needed to send input from combo box back to bindings.
        func controlTextDidEndEditing(_ obj: Notification) {
            guard let combo = obj.object as? NSComboBox else { return }
            
            self.parent.selectedItem = combo.stringValue
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
    
    // declare function that does nothing to satisfy NSViewRepresentable.
    func updateNSView(_ nsView: NSComboBox, context: NSViewRepresentableContext<macComboBox>) {
        guard let combo = nsView as? NSComboBox else { return }
        
        guard selectedItem != combo.stringValue else { return }
        
        combo.stringValue = selectedItem
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        macComboBox(content: .constant(["Hello", "World", "7"]), selectedItem: .constant("Hello"))
    }
}
#endif
