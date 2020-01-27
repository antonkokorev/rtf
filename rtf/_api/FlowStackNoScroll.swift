//
//  FlowStack.swift
//  rtf
//
//  Created by Anton Elistratov on 16.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct FlowStackNoScroll<Content>: View where Content: View {
    // The number of columns we want to display
    var columns: Int
    // The total number of items in the stack
    var numItems: Int
    // The alignment of our columns in the last row
    // when they don't fill all the column slots
    var alignment: HorizontalAlignment
    
    public let content: (Int, CGFloat) -> Content
    
// <--- refactoring start

    private func width(for size: CGSize)-> CGFloat {
        return size.width/CGFloat(self.columns)
    }
    
    private func index(forRow row: Int, column: Int) -> Int {
        return (row * self.columns) + column
    }
    
    private var lastRowColumns : Int { get { return numItems % columns }    }
    
    private var rows : Int { get { return numItems / columns } }

// <--- refactoring end
    
    public init(
        columns: Int,
        numItems: Int,
        alignment: HorizontalAlignment?,
        @ViewBuilder content: @escaping (Int, CGFloat) -> Content) {
        self.content = content
        self.columns = columns
        self.numItems = numItems
        self.alignment = alignment ?? HorizontalAlignment.leading
    }

    public var body : some View {
        // A GeometryReader is required to size items in the scroll view
        GeometryReader { geometry in
            
            // Assume a vertical scrolling orientation for the grid
           // ScrollView(Axis.Set.vertical) {
                
                // VStacks are our rows
                VStack(alignment: self.alignment, spacing: 0) {
                    ForEach(0 ..< self.rows, id: \.self) { row in
                        
                        // HStacks are our columns
                        HStack(spacing: 0) {
                            ForEach(0 ..< self.columns, id: \.self) { column in
                                Group{
                                self.content(
                                    // Pass the index to the content
                                    self.index(forRow: row, column: column),
                                    // Pass the column width to the content
                                    self.width(for: geometry.size)
                                )
                                    // Size the content to frame to fill the column
                                    .frame(width: self.width(for: geometry.size))
                                }
                            }
                        }
                    }
                    
                    // Last row
                    // HStacks are our columns
                    HStack(spacing: 0) {
                        ForEach(0 ..< self.lastRowColumns, id: \.self) { column in
                            self.content(
                                // Pass the index to the content
                                self.index(forRow: self.rows, column: column),
                                // Pass the column width to the content
                                self.width(for: geometry.size)
                            )
                                // Size the content to frame to fill the column
                                .frame(width: self.width(for: geometry.size))
                        }
                        Spacer()
                    }
                }
            //}
        }
    }
}
