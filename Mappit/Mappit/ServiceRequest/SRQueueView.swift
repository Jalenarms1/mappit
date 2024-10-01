//
//  SRQueueView.swift
//  Mappit
//
//  Created by Jalen Arms on 9/30/24.
//

import SwiftUI

struct SRQueueView: View {
    var serviceRequests: [ServiceRequest]
    
    var body: some View {
        VStack {
            Spacer()
            
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack {
//                    ForEach(serviceRequests) { r in
//                        SRQCardView(r: r)
//                    }
//                }
//                .frame(maxHeight: .infinity)
//                
//            }
//            .frame(maxWidth: .infinity, maxHeight: 200)
//            .background(Color(.white).opacity(0.9))
//            .shadow(radius: 2)
            
        }
    }
}

struct SRQCardView: View {
    var r: ServiceRequest
    
    var body: some View {
        GroupBox {
            
            VStack {
                Text("Address")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color.blue)

            }
            
        } label: {
            HStack {
                Image(systemName: r.urgency.urgencyImage)
                    .resizable()
                    .imageScale(.large)
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.white)
                    .padding(7)
                    .background(Color(r.urgency.urgencyColor))
                    .clipShape(.circle)
                    
                HStack (spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Status")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color.blue)
                        
                        
                        Text("\(r.status.rawValue)")
                            .font(.system(.body))
                        
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Created at")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color.blue)

                        
                        Text("\(r.createdAt.formatted(date: .omitted, time: .shortened))")
                            .font(.system(.body))
                        
                    }
                    
                }

            }
            
            Spacer()
            
        }
        .frame(minWidth:375, maxWidth: 375, maxHeight: .infinity)
        .padding()
    }
}
