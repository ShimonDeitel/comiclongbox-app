import Foundation

struct Issue: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var issueNumber: Int
    var condition: String
    var notes: String
}
