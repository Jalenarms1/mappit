//
//  SRSheet.swift
//  Mappit
//
//  Created by Jalen Arms on 9/30/24.
//

import SwiftUI


struct SRSheet: View {
    var serviceReq: ServiceRequest
    @Binding var showSRSheet: Bool
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: serviceReq.urgency.urgencyImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(5)
                    .background(Color(serviceReq.urgency.urgencyColor))
                    .foregroundStyle(Color.white)
                    .clipShape(.circle)
                
                Spacer()
                
                Button {
                    showSRSheet = false
                } label: {
                    Image(systemName: "xmark")
                }
                
            }
            
            Text(serviceReq.address)
                .font(.system(size: 20, weight: .semibold))
            
            Spacer()
        }
        .padding()
    }
}
