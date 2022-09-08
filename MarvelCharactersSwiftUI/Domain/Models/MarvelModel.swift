import Foundation

// MARK: - CharacterModel
struct Marvel: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable, Identifiable {
    let id: Int
    let name: String?
    let thumbnail: Thumbnail
    let title: String?
    let description: String?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }

    func getUrlThumbnail() -> String {
        return "\(path).\(thumbnailExtension)"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}
