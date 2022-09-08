import SwiftUI

struct SeriesDetailView : View {
    
    var character: Result
    @StateObject var seriesViewModel = SeriesViewModel()
    
    init(character: Result){
        self.character = character
    }
    
    var body: some View {
        List{
            if let series = seriesViewModel.series?.data.results {
                ForEach(series) { data in
                    SeriesRowView(serie: data)
                }
            }
        }
        .onAppear{
            seriesViewModel.getCharacterSeries(characterId: self.character.id)
        }
        .navigationBarTitle("\(character.name!)", displayMode: .inline)
    }
}



