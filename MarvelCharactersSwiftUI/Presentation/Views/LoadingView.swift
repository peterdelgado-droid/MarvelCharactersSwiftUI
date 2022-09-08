import SwiftUI

struct LoadingView: View {
    
    @State private var open = false
    
    var body: some View {
        VStack{
            Circle()
                .foregroundColor(Color.blue)
                .frame(width: 100, height: 100)
                .scaleEffect(self.open ? 0.5 : 1.0)
                .animation(.easeInOut(duration: 0.5).repeatForever(), value: open)
                .onAppear {
                    self.open = true
                }
                .onDisappear {
                    self.open = false
                }
            
            Text("Cargando...")
                .foregroundColor(Color.blue)
                .bold()
        }
    }
    
    struct LoadingView_Previews: PreviewProvider {
        static var previews: some View {
            LoadingView()
        }
    }
}
