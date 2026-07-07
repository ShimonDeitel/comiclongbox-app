import XCTest
@testable import Comic Longbox

@MainActor
final class Comic LongboxTests: XCTestCase {
    func testSeedDataBelowFreeLimit() {
        XCTAssertLessThan(Store.seedData.count, Store.freeLimit)
    }

    func testAddIncreasesCount() {
        let store = Store()
        let before = store.items.count
        let item = Issue(id: UUID(), title: String = "", issueNumber: Int = 0, condition: String = "", notes: String = "")
        store.add(item)
        XCTAssertEqual(store.items.count, before + 1)
    }

    func testDeleteDecreasesCount() {
        let store = Store()
        let item = Issue(id: UUID(), title: String = "", issueNumber: Int = 0, condition: String = "", notes: String = "")
        store.add(item)
        let before = store.items.count
        store.delete(item)
        XCTAssertEqual(store.items.count, before - 1)
    }

    func testCanAddMoreWhenBelowLimit() {
        let store = Store()
        store.isPro = false
        XCTAssertTrue(store.canAddMore)
    }

    func testCannotAddMoreAtFreeLimitWithoutPro() {
        let store = Store()
        store.isPro = false
        for _ in 0..<(Store.freeLimit) {
            store.add(Issue(id: UUID(), title: String = "", issueNumber: Int = 0, condition: String = "", notes: String = ""))
        }
        XCTAssertFalse(store.canAddMore)
    }

    func testProBypassesLimit() {
        let store = Store()
        store.isPro = true
        for _ in 0..<(Store.freeLimit + 5) {
            store.add(Issue(id: UUID(), title: String = "", issueNumber: Int = 0, condition: String = "", notes: String = ""))
        }
        XCTAssertTrue(store.canAddMore)
    }

    func testUpdateModifiesItem() {
        let store = Store()
        var item = Issue(id: UUID(), title: String = "", issueNumber: Int = 0, condition: String = "", notes: String = "")
        store.add(item)
        item.title = "Updated"
        store.update(item)
        XCTAssertEqual(store.items.first(where: { $0.id == item.id })?.title, "Updated")
    }

    func testDeleteAtOffsets() {
        let store = Store()
        let item = Issue(id: UUID(), title: String = "", issueNumber: Int = 0, condition: String = "", notes: String = "")
        store.add(item)
        if let idx = store.items.firstIndex(where: { $0.id == item.id }) {
            store.delete(at: IndexSet(integer: idx))
        }
        XCTAssertFalse(store.items.contains(where: { $0.id == item.id }))
    }
}
