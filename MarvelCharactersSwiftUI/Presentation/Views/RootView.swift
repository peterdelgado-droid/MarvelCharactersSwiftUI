import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var characterViewModel : CharactersViewModel
    
    var body: some View {
        
        switch characterViewModel.status {
            case .none:
                Text("¡No hay vistas que cargar!")
            case Status.loading:
                LoadingView()
            case Status.loaded:
                CharactersView(characterViewModel: characterViewModel)
            case Status.error(error: let error):
                ErrorView(error: "Error: \(error)")
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
