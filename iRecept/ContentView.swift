//
//  ContentView.swift
//  iRecept
//
//  Created by Jan Kubín on 17.07.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Recepty.entity(), sortDescriptors: []) var recepty: FetchedResults<Recepty>
    @FetchRequest(entity: Suroviny.entity(), sortDescriptors: []) var suroviny: FetchedResults<Suroviny>
    
    @State private var showingAddScreen = false
    var body: some View {
        NavigationView {
            List {
                ForEach(recepty) { recept in
                    NavigationLink(destination: DetailView(recept: recept)) {
                        VStack {
                            Text(recept.nazev ?? "")
                            Text(recept.kategorie ?? "")
                        }
                    }
                }
            }
            .navigationTitle("Recepty")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddReceptView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
