//
//  DetailView.swift
//  iRecept
//
//  Created by Jan Kubín on 18.07.2023.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Recepty.entity(), sortDescriptors: []) var recepty: FetchedResults<Recepty>
    @FetchRequest(entity: Suroviny.entity(), sortDescriptors: []) var suroviny: FetchedResults<Suroviny>
    
    let recept: Recepty
    
    var body: some View {
        ScrollView {
            VStack {
                Text(recept.nazev ?? "")
                    .font(.title)
                    .padding()
                
                Text("Popis receptu:")
                    .font(.headline)
                    .padding(.top)
                
                Text(recept.popis ?? "")
                    .padding(.horizontal)
                
                Text("Kategorie:")
                    .font(.headline)
                    .padding(.top)
                
                Text(recept.kategorie ?? "")
                    .padding(.horizontal)
                
                Text("Porce:")
                    .font(.headline)
                    .padding(.top)
                
                Text("\(recept.porce)")
                    .padding(.horizontal)
                
                Text("Suroviny:")
                    .font(.headline)
                    .padding(.top)
                
                ForEach(Array(arrayLiteral: recept.suroviny ?? NSSet()), id: \.self) { surovina in
                    if let surovinaObj = surovina as? Suroviny {
                        Text("\(surovinaObj.mnozstvi ?? "")x \(surovinaObj.nazev ?? "")")
                            .padding(.horizontal)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Detail receptu")
    }
}



