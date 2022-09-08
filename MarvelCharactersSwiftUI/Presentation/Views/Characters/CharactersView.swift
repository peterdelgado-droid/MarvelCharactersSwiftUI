import SwiftUI

struct CharactersView: View {
    
    @StateObject var characterViewModel: CharactersViewModel
    
    var body: some View {
        NavigationView{
            List{
                if let characters = characterViewModel.characters?.data.results {
                    ForEach(characters){ data in
                        NavigationLink(
                            destination: SeriesDetailView(character: data),
                            label: {
                                CharacterRowView(character: data)
                            })
                    }
                } 
            }
            .navigationBarTitle(Text("Marvel Characters"), displayMode: .inline)
        }
    }
}
