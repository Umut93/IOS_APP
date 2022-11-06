struct Responsible: Hashable, Equatable, Codable {
    let identifier: String
    let name: String
    let isUserLoggedIn: Bool

    init(identifier: String, name: String, IsUserLoggedin: Bool = false) {
        self.identifier = identifier
        self.name = name
        isUserLoggedIn = IsUserLoggedin
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        name = try container.decode(String.self, forKey: .name)
        isUserLoggedIn = false
    }

    private enum CodingKeys: String, CodingKey {
        case identifier, name
    }
}
