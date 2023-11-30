//
//  FooterView.swift
//  RandomUserPhone
//
//  Created by Jonashio on 29/11/23.
//

import SwiftUI

struct FooterView: View {
    var status: Status

    var body: some View {
        ZStack(alignment: .center) {
            switch status {
            case .loading:
                ProgressView()
            case .idle:
                ZStack {}
                    .frame(maxWidth: .infinity, idealHeight: 10)
                    .background(.white)
            case .error:
                VStack {
                    Text("Error loading data...")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.yellow)
                        .padding(EdgeInsets(top: 3, leading: 10, bottom: 3, trailing: 10))
                }
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hex: "3F3F3F"))

                }
            }
        }
        .frame(height: 50)
        .onChange(of: status) { oldValue, newValue in
            guard newValue == .idle else { return }
        }
    }
}

#Preview(nil, traits: .fixedLayout(width: 150, height: 50), body: {
    FooterView(status: .error)
})
