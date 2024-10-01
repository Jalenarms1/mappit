//
//  SRAnnotation.swift
//  Mappit
//
//  Created by Jalen Arms on 9/28/24.
//

import SwiftUI

struct SRAnnotation: View {
    var urgencyLevel: SRUrgency
    
    var body: some View {
        Image(systemName: urgencyLevel.urgencyImage)
            .resizable()
            .foregroundStyle(.white)
            .frame(width: 45, height: 45)
            .padding()
            .background(urgencyLevel.urgencyColor)
            .clipShape(.circle)
            .shadow(radius: 2)
        
    }
    
    
}

