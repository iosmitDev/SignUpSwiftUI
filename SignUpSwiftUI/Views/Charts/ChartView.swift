//
//  ChartView.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 17/12/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Chart(MockData) { item in
                    
                    SectorMark(angle: .value("Label", item), innerRadius: .ratio(0.5), angularInset: 2)
                        .foregroundStyle(item.color)
                }
            }
            .navigationTitle("Pie Charts")
        }
    }
}

#Preview {
    ChartView()
}
