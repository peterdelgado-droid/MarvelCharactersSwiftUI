import Foundation
import Combine

final class SeriesViewModel: ObservableObject {
    
    @Published var status = Status.none
    var series: Marvel?
    var suscriptor = Set<AnyCancellable>()
    
    init(testing: Bool = true) {
        if (testing) {
            print("Hay series que mostrar")
        } else {
            getCharacterSeriesMOCK()
        }
    }
    
    func getCharacterSeries(characterId: Int){
        self.status = Status.loading
        
        guard let urlRequest = BaseNetwork().getSessionCharacterSeries(characterId: characterId) else {
            return
        }
        
        URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: Marvel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .failure:
                        self.status = Status.error(error: "¡Error! Buscando las series...")
                    case .finished:
                        self.status = Status.loaded
                }
            } receiveValue: { data in
                self.series = data
            }
            .store(in: &suscriptor)
    }
    
    func getCharacterSeriesMOCK(){
        self.status = Status.loading
        
        let serieUno = Result(id: 1, name: "Name 1", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/30/4ce69c2246c21", thumbnailExtension: Extension.jpg), title: "Title 1", description: "Description 1")
        let serieDos = Result(id: 2, name: "Name 2", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/f/40/4ce5a8b16ee4b", thumbnailExtension: Extension.jpg), title: "Title 2", description: "Description 2")
        let serieTres = Result(id: 3, name: "Name 3", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/a/20/4ce5a878b487c", thumbnailExtension: Extension.jpg), title: "Title 3", description: "Description 3")
        let serieCuatro = Result(id: 4, name: "Name 4", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/b0/526958a4c3cde", thumbnailExtension: Extension.jpg), title: "Title 4", description: "Description 4")
        let serieCinco = Result(id: 5, name: "Name 5", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/30/4ce69c2246c21", thumbnailExtension: Extension.jpg), title: "Title 5", description: "Description 5")
        
        
        let data = DataClass(results: [serieUno, serieDos, serieTres, serieCuatro, serieCinco])
        
        self.series = Marvel(data: data)
        self.status = Status.loaded
        
    }
}
