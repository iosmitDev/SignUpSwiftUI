//
//  MockChartData.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 17/12/24.
//

import Foundation
import SwiftUI
import Charts

//We need to create chart so we need id, Color and plottableData => We use Plottable protocol and import charts
struct MockChartData: Identifiable, Plottable {
    
    var id = UUID().uuidString
    let primitivePlottable: Int
    let color: Color
    
    init?(primitivePlottable: Int) {
        self.primitivePlottable = primitivePlottable
        self.color = .blue
    }
    
    init?(primitivePlottable: Int, color: Color) {
        self.primitivePlottable = primitivePlottable
        self.color = color
    }
    
}

let MockData: [MockChartData] = [
    MockChartData(
        primitivePlottable: 12,
        color: .red
    )!,
    MockChartData(
        primitivePlottable: 6,
        color: .blue
    )!,
    MockChartData(
        primitivePlottable: 31,
        color: .orange
    )!,
    MockChartData(
        primitivePlottable: 11,
        color: .green
    )!,
    MockChartData(
        primitivePlottable: 38,
        color: .purple
    )!,
    MockChartData(
        primitivePlottable: 18,
        color: .pink
    )!,
    MockChartData(
        primitivePlottable: 7,
        color: .yellow
    )!
]


