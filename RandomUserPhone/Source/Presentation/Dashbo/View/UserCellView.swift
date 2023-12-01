//
//  UserCellView.swift
//  RandomUserPhone
//
//  Created by Jonashio on 29/11/23.
//

import SwiftUI
import Kingfisher

struct UserCellView: View {
    
    var user: User
    var namespace: Namespace.ID
    var action: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                ZStack {
                    KFImage(URL(string: user.picture.medium))
                        .loadDiskFileSynchronously()
                        .cacheMemoryOnly()
                        .scaleFactor(UIScreen.main.scale)
                        .resizing(referenceSize: CGSize(width: 70, height: 70))
                        .clipShape(Circle())
                        .matchedGeometryEffect(id: "img_\(user.id)", in: namespace)
                }
                .frame(width: 70, height: 70)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 0))

                
                VStack(spacing: 3) {
                    HStack{
                        Text(user.name)
                            .matchedGeometryEffect(id: "name_\(user.id)", in: namespace)
                        Spacer()
                        
                        Menu {
                            Button("Copy", action: {UIPasteboard.general.string = user.phone})
                            
                            Button("Call \(user.phone)", action: {Utilities.callPhone(user.phone)})
                        } label: {
                            Image(systemName: "phone.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }

                    }
                    
                    Divider()
                        .background(.gray)
                    
                    HStack{
                        Text(user.email)
                            .matchedGeometryEffect(id: "email_\(user.id)", in: namespace)
                        Spacer()
                        ZStack {
                            Circle()
                                .tint(.white)
                                .frame(width: 20, height: 20)
                            Image(user.gender.getNameIcon())
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                        }
                    }
                }
                .font(.caption)
                .foregroundColor(.white)
                .bold()
                .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 20))
            }
        }.background{
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "1F222A"))
                .onTapGesture(perform: action)
                .matchedGeometryEffect(id: "background_\(user.id)", in: namespace)
        }
    }
}

#Preview {
    UserCellView(user: .fakeItem(), namespace: Namespace().wrappedValue, action: {})
}
