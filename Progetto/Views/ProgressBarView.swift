//
//  ProgressBarView.swift
//  Progetto
//
//  Created by Lorenzo on 15/02/24.
//

import SwiftUI

struct ProgressBarView: View {
    @Binding var current: Int
    let total: Double
    var body: some View {
        VStack {
            //note: GeometryReader takes up all available space
            GeometryReader { geometry in
                var currentWidth = CGFloat(Double(self.current) / self.total) * 0.9 * geometry.size.width
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: currentWidth,
                           height: 10, alignment: .center)
                    .cornerRadius(geometry.size.height / 2)
                    .padding()
            }
        }
    }
}

#Preview {
    ProgressBarView(current: .constant(100), total: 100)
}
