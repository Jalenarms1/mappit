//
//  MappitApp.swift
//  Mappit
//
//  Created by Jalen Arms on 9/26/24.
//

import SwiftUI

@main
struct MappitApp: App {
    
    init() {
        let appr = UITabBarAppearance()
        appr.backgroundColor  = UIColor.systemGray6
        
        UITabBar.appearance().standardAppearance = appr
        UITabBar.appearance().scrollEdgeAppearance = appr
    }
    
    
    var body: some Scene {
        WindowGroup {
            MapView()
//            TabView {
//                    .tabItem {
//                        VStack {
//                            Image(systemName: "house")
//                                .resizable()
//                                .scaledToFill()
//                            Text("Map")
//                        }
//                    }
//                    
//            }
        }
    }
}

