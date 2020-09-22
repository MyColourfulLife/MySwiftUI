//
//  Grid.swift
//  Memorize
//
//  Created by JiaShu Huang on 2020/9/22.
//

import SwiftUI

struct Grid<Item,ItemView>: View where Item:Identifiable, ItemView:View {
    var items:[Item]
    var viewForItem: (Item) -> ItemView
    
    init(items:[Item], viewForItem:@escaping (Item)->ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { gemory in
            body(for: GridLayout(itemCount: items.count, in: gemory.size))
        }
    }
    
    func body(for layout:GridLayout) -> some View {
        ForEach(items) { item in
            let index = items.firstIndex(matching:item)!
            viewForItem(item)
                .frame(width:layout.itemSize.width,height:layout.itemSize.height)
                .position(layout.location(ofItemAt: index))
        }
    }
    
}


