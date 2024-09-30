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
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(serviceRequests) { r in
                        
                        GroupBox {
                            
                            Spacer()
                            
                            HStack {
                                
                                VStack {
                                    Spacer()
                                    
                                    HStack {
                                        Button {
                                            
                                        } label: {
                                            Image(systemName: "paperplane.circle")
                                                .resizable()
                                                .foregroundStyle(.blue)
                                                .frame(width: 30, height: 30)
                                                .clipShape(.circle)
                                                .shadow(radius: 2)
                                            
                                            Text("On the way")
                                                .bold()
                                            
                                        }
                                        .padding(7)
                                        .cornerRadius(5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color.blue, lineWidth: 2)
                                        )
                                        
                                        Spacer()
                                        
                                    }
                                    .padding(.bottom, 10)
                                    
                                    HStack {
                                        Text(r.createdAt.formatted(date: .omitted, time: .shortened))
                                            .font(.system(.body))
                                            .foregroundStyle(Color.white)
                                        
                                        Spacer()
                                    }
                                    
                                    
                                    
                                }
                                
                                Spacer()
                                VStack {
                                    Spacer()
                                    
                                    HStack {
                                        SRAnnotation(urgencyLevel: r.urgency)
                                    }
                                }
                            }
                            .frame(maxWidth:.infinity, alignment: .leading)
                            
                        } label: {
                            Text(r.address)
                                .font(.system(.title2, weight: .bold))
                                .foregroundStyle(Color.white)
                            
                        }
                        .frame(maxHeight: 200)
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 20)
                        .backgroundStyle(Color(.black).opacity(0.85))
                        
                    }
                }
            }
            .padding()
            
            
        }
        
    }
}
