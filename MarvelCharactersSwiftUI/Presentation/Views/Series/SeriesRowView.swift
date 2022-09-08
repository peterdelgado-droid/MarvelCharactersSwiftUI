import SwiftUI

struct SeriesRowView: View {
    
    @StateObject private var imageViewModel = ImageViewModel()
    var serie : Result
    
    var body: some View {
        HStack{
            if let photo = imageViewModel.photo {
                photo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 120, alignment: .center)
                    .cornerRadius(5)
                    .padding( .trailing, 20)
            }else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5)
                    .padding([.leading, .trailing], 20)
            }
            
            VStack(alignment: .leading){
                if(serie.title != nil) {
                    Text("\(serie.title!)")
                        .font(.body)
                        .bold()
                } else {
                    Text("--")
                        .font(.body)
                }
                
                if(serie.description != nil) {
                    Text("\(serie.description!)")
                        .lineLimit(3)
                } else {
                    Text("--")
                }
            }

        }
        .onAppear{
            imageViewModel.loadImage(url: serie.thumbnail.getUrlThumbnail())
        }
    }
}
