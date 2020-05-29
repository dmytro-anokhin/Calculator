//
//  Grid.swift
//  Calculator
//
//  Created by Dmytro Anokhin on 28/05/2020.
//  Copyright © 2020 Dmytro Anokhin. All rights reserved.
//

import SwiftUI


/// A container that arranges its views as cells in a grid layout.
struct Grid<Content: View>: View {

    private let content: () -> Content

    /// Creates a Grid that computes its cell views on demand from an underlying collection of data.
    ///
    /// - Parameters:
    ///     - data: A two dimensional collection of identified data.
    ///     - alignment: Horizontal alignment of cell views in a row.
    ///     - cellContent: A view builder that creates the view for a single cell of the grid.
    ///     - element: An element in the collection.
    init<Data, RowID, ColID, CellContent>(
        data: Data,
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder cellContent: @escaping (_ element: Data.Element.Element) -> CellContent
    )
        where Content == VStack<ForEach<Data, RowID, HStack<ForEach<Data.Element, ColID, CellContent>>>>,
            Data : RandomAccessCollection,
            Data.Element : RandomAccessCollection,
            RowID == Data.Element,
            ColID == Data.Element.Element,
            CellContent : View
    {
        content = {
            VStack(alignment: alignment) {
                ForEach(data, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { cell in
                            cellContent(cell)
                        }
                    }
                }
            }
        }
    }

    var body: some View {
        content()
    }
}


struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid(data: [[1, 2, 3], [4, 5, 6], [7], [8, 9]]) { element in
            Text(String(element))
        }
    }
}
