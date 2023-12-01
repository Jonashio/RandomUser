//
//  ContentView.swift
//  RandomUser
//
//  Created by Jonashio on 27/11/23.
//

import SwiftUI
import SwiftData

struct DashboUsersView: View {
    @Environment(DashboUsersViewModel.self) private var vm
    @Environment(\.modelContext) var modelContext
    @State private var searchText = ""
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            if let user = vm.userSelected {
                DetailUserView(user: user, namespace: namespace) {
                    vm.doSelectUser(nil)
                }
            }else{
                VStack {
                    TextField("Searcher", text: $searchText)
                    
                    List{
                        ForEach(vm.users, id: \.id) { user in
                            
                            UserCellView(user: user, namespace: namespace){
                                vm.doSelectUser(user)
                            }.onAppear{
                                vm.doPagination(user)
                            }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                        }
                        .onDelete(perform: vm.doRemove)
                        
                        FooterView(status: vm.status)
                    }
                    .listStyle(.plain)
                    .background(.clear)
                    .onChange(of: searchText) { oldValue, newValue in
                        vm.doFilter(searchText)
                    }
                }.padding()
            }
        }
        .task{
            vm.loadSavedData(modelContext)
            DispatchQueue.mainAfter(deadline: .now() + 1.0) {
                Task{ await vm.fetchData() }
            }
        }
    }
}

#Preview {
    DashboUsersView()
        .modelContainer(try! ModelContainer(for: UserPersistenceModel.self))
        .environment(DashboUsersViewModel(useCase: GetUsersUseCase(repository: NetworkGeneric(predefinedDataTest: LocalFileManager.loadPrivateFile(filename: "randomuser", ofType: "json")))))
        
}
