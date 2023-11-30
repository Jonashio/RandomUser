//
//  RandomUserPhoneApp.swift
//  RandomUserPhone
//
//  Created by Jonashio on 28/11/23.
//

import SwiftUI
import SwiftData

@main
struct RandomUserApp: App {
    @State private var dashboVM = DashboUsersViewModel(useCase: GetUsersUseCase()) //Se podria crear un assembler para la instancia de esto
    @State var isFinishedSplash = false
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: UserPersistenceModel.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if isFinishedSplash{
                DashboUsersView()
                    .environment(dashboVM)
            }else{
                SplashView(isFinished: $isFinishedSplash)
            }
        }
        .modelContainer(modelContainer)
    }
}
