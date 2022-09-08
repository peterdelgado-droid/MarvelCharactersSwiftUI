import Foundation
import Combine

final class CharactersViewModel: ObservableObject {
    
    @Published var status = Status.none
    var characters : Marvel?
    var suscriptor = Set<AnyCancellable>()
    
    init(testing: Bool = true) {
        if testing == true {
            self.getCharacters()
        } else {
            getCharactersMOCK()
        }
    }
    
    func getCharacters() {
        self.status = Status.loading
        
        guard let urlRequest = BaseNetwork().getSessionCharacters() else {
            return
        }
        
        URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { (data: Data, response: URLResponse) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: Marvel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .finished:
                        self.status = Status.loaded
                    case .failure:
                        self.status = Status.error(error: "¡Error! Buscando los personajes...")
                }
            } receiveValue: { data in
                self.characters = data
            }
            .store(in: &suscriptor)
    }
    
    func getCharactersMOCK(){
        self.status = Status.loading
        
        let characterUno = Result(id: 1, name: "Name 1", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/30/4ce69c2246c21", thumbnailExtension: Extension.jpg), title: "Title 1", description: "Description 1")
        let characterDos = Result(id: 2, name: "Name 2", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/f/40/4ce5a8b16ee4b", thumbnailExtension: Extension.jpg), title: "Title 2", description: "Description 2")
        let characterTres = Result(id: 3, name: "Name 3", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/a/20/4ce5a878b487c", thumbnailExtension: Extension.jpg), title: "Title 3", description: "Description 3")
        let characterCuatro = Result(id: 4, name: "Name 4", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/b0/526958a4c3cde", thumbnailExtension: Extension.jpg), title: "Title 4", description: "Description 4")
        let characterCinco = Result(id: 5, name: "Name 5", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/30/4ce69c2246c21", thumbnailExtension: Extension.jpg), title: "Title 5", description: "Description 5")
        
        
        let data = DataClass(results: [characterUno, characterDos, characterTres, characterCuatro, characterCinco])
        
        self.characters = Marvel(data: data)
        self.status = Status.loaded
        
    }
}
