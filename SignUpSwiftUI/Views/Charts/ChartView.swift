//
//  ChartView.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 17/12/24.
//

import SwiftUI
import Charts

/*
 
 //Commit messages for Git

 New feature :
 [Feature] Description of the feature

 Bug in Production :
 [Patch] Description of the patch

 Bug Not in Production But In my App :
 [Bug] Description of the bug

 Release Comments on Production :
 [Release] Description of the release

 Mundane Tasks :
 [Clean] description of changes
 
 */

struct ChartView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Chart(MockData) { item in
                    
                    SectorMark(angle: .value("Label", item), innerRadius: .ratio(0.5), angularInset: 1)
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
