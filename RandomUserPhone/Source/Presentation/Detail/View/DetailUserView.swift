//
//  DetailUserView.swift
//  RandomUserPhone
//
//  Created by Jonashio on 30/11/23.
//

import SwiftUI
import Kingfisher

struct DetailUserView: View {
    
    // MARK: - Properties
    var user: User
    var namespace: Namespace.ID
    var close: () -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack {
                    KFImage(URL(string: user.picture.large))
                        .loadDiskFileSynchronously()
                        .cacheMemoryOnly()
                        .scaleFactor(UIScreen.main.scale)
                        .resizing(referenceSize: CGSize(width: 250, height: 250))
                        .clipShape(Circle())
                        .padding()
                        .matchedGeometryEffect(id: "img_\(user.id)", in: namespace)
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .overlay(content: buildButtonClose)

                VStack {
                    VStack {
                        buildField(field: "Name", value: user.name)
                            .matchedGeometryEffect(id: "name_\(user.id)", in: namespace)
                        buildField(field: "Email", value: user.email)
                            .matchedGeometryEffect(id: "email_\(user.id)", in: namespace)
                        buildField(field: "Gender", value: user.gender.rawValue)
                        buildField(field: "Street", value: user.detail.street)
                        buildField(field: "City", value: user.detail.city)
                        buildField(field: "Country", value: user.detail.country)
                    }
                    .foregroundColor(.white)
                    .font(.callout)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background{
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(hex: "1F222A"))
                        .matchedGeometryEffect(id: "background_\(user.id)", in: namespace)
                }
                
                Spacer()
                
            }
        }
    }
    
    func buildField(field: String, value: String) -> some View {
        HStack {
            Text("\(field):")
            Spacer()
            Text(value)
        }
    }
    
    func buildButtonClose() -> some View {
        VStack {
            Button(action: close) {
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.black)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }
}

#Preview {
    DetailUserView(user: .fakeItem(), namespace: Namespace().wrappedValue, close: {})
}
