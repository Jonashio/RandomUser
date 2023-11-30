//
//  SplashView.swift
//  RandomUserPhone
//
//  Created by Jonashio on 28/11/23.
//

import SwiftUI

struct SplashView: View {
    @Binding var isFinished: Bool
    var body: some View {
        ZStack {
            LottieView(name: Constants.Lottie.splash, loopMode: .playOnce)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Constants.Lottie.splashBackground)
        .onAppear{
            Timer.scheduledTimer(withTimeInterval: 4.3, repeats: false) { _ in
                withAnimation { isFinished.toggle() }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(isFinished: .constant(false))
    }
}
