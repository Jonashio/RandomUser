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
        var inMemory = false

        #if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            inMemory = true
        }
        #endif
        
        do {
            let config = ModelConfiguration(for: UserPersistenceModel.self, isStoredInMemoryOnly: inMemory)
            modelContainer = try ModelContainer(for: UserPersistenceModel.self, configurations: config)
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
