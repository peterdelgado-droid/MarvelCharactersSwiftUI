import SwiftUI

struct CharacterRowView : View {
    
    var character : Result
    @StateObject private var imageViewModel = ImageViewModel()
    
    var body: some View {
        LazyVStack {
            if let image = imageViewModel.photo {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 200, alignment: .center)
                    .cornerRadius(5)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 200, alignment: .center)
                    .cornerRadius(5)
            }
            
            if(character.name != nil) {
                Text("\(character.name!)")
                    .font(.title3)
                    .bold()
            } else {
                Text("--")
            }
        }
        .padding(.vertical, 20)
        .onAppear{
            imageViewModel.loadImage(url: character.thumbnail.getUrlThumbnail())
        }
    }
}
