import Foundation

enum Status {
    case none, loading, loaded, error(error: String)
}
