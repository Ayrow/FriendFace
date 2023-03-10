//
//  DetailView.swift
//  FriendFace
//
//  Created by Aymeric Pilaert on 10/03/2023.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        NavigationStack {
            VStack {
                Section {
                    ZStack {
                        LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                            .frame(height: 300)
                        
                        VStack {
                            Text("Contact Info:")
                                .font(.largeTitle)
                                .padding(.bottom)
                            Text("\(user.name)")
                                .font(.title)
                            Text("\(user.address)")
                                .font(.title3)
                                .multilineTextAlignment(.center)
                            Text("\(user.email)")
                                .font(.title3)
                            
                            Text("Registered: \(user.simplifiedDate)")
                                .padding(.vertical)
                        }
                        .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                Section {
                    ScrollView {
                        Text("\(user.about)")
                    }
                } header: {
                    Text("About")
                        .font(.title)
                }.padding()
                
                
                
                
                
            }
            
            .toolbar {
                Button {
                    //
                } label: {
                    Label("Delete user", systemImage: "trash")
                }

            }
            .navigationTitle(user.name)
            
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailView(user: User(id: UUID(), name: "Johnny", age: 12, company: "Apple", about: "This is about me", isActive: true, email: "apple@hotmail.com", registered: Date.now, friends: [], address: "566 route des vignes", tags: ["bananas"]))
    }
}
