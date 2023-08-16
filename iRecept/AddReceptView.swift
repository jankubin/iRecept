//
//  AddReceptView.swift
//  iRecept
//
//  Created by Jan Kubín on 17.07.2023.
//

import SwiftUI
import CoreData

struct AddReceptView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Recepty.entity(), sortDescriptors: []) var recepty: FetchedResults<Recepty>
    @FetchRequest(entity: Suroviny.entity(), sortDescriptors: []) var suroviny: FetchedResults<Suroviny>
    @State private var nazev = ""
    @State private var kategorie = ""
    @State private var popis = ""
    @State private var porce = 1
    @State private var surovina = ""
    @State private var mnozstvi = ""
    @State private var surovinyList = [Suroviny]()
    
    let kategorieReceptu = ["Maso", "Bezmasé", "Fit"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Název", text: $nazev)
                }
                
                Section {
                    TextField("Množství", text: $mnozstvi)
                    TextField("Surovina", text: $surovina)
                    Button("Přidat") {
                        addSurovinu()
                    }
                }
                
                Section(header: Text("Přidané suroviny")) {
                    List {
                        ForEach(surovinyList, id: \.self) { surovina in
                            Text("\(surovina.mnozstvi ?? "")x \(surovina.nazev ?? "")")
                        }
                    }
                }
                
                Section(header: Text("Popis receptu")) {
                    TextEditor(text: $popis)
                    Picker("Kategorie:", selection: $kategorie) {
                        ForEach(kategorieReceptu, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    Stepper("Porce: \(porce)", value: $porce)
                }
                
                Section {
                    Button("Uložit") {
                        save()
                    }
                }
            }
            .navigationTitle("Nový recept")
        }
    }
    
    func addSurovinu() {
        let newSurovina = Suroviny(context: moc)
        newSurovina.nazev = surovina
        newSurovina.mnozstvi = mnozstvi
        
        surovinyList.append(newSurovina)
        
        surovina = ""
        mnozstvi = ""
    }
    
    func save() {
        let newRecept = Recepty(context: moc)
        newRecept.id = UUID()
        newRecept.nazev = nazev
        newRecept.kategorie = kategorie
        newRecept.popis = popis
        newRecept.porce = Int16(porce)
        
        for surovina in surovinyList {
            newRecept.addToSuroviny(surovina)
        }
        
        do {
            try moc.save()
        } catch {
            print("Chyba při ukládání receptu: \(error)")
        }
    }
}


struct AddReceptView_Previews: PreviewProvider {
    static var previews: some View {
        AddReceptView()
    }
}
