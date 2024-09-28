//
//  SRAnnotation.swift
//  Mappit
//
//  Created by Jalen Arms on 9/28/24.
//

import SwiftUI
import MapKit

struct SRAnnotation: View {
    var urgencyLevel: SRUrgency
    
    var body: some View {
        Image(systemName: urgencyLevel.urgencyImage)
            .resizable()
            .foregroundStyle(.white)
            .frame(width: 50, height: 50)
            .padding()
            .background(urgencyLevel.urgencyColor)
            .clipShape(.circle)
    }
    
    
}

