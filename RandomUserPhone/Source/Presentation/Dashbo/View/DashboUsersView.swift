//
//  ContentView.swift
//  RandomUser
//
//  Created by Jonashio on 27/11/23.
//

import SwiftUI

struct DashboUsersView: View {
    @Environment(DashboUsersViewModel.self) private var usersVM
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world! \(usersVM.users.count)")
            Text("Status: \(usersVM.status.hashValue)")
            
        }
        .padding()
        .task(usersVM.fetchData)
    }
}

#Preview {
    DashboUsersView()
}
