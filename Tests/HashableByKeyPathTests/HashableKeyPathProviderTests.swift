import XCTest
@testable import HashableByKeyPath

final class HashableKeyPathProviderTests: XCTestCase {

    func testHashableByKeyPath() {
        struct Foo: HashableByKeyPath {
            static func addHashableKeyPaths<Consumer>(to consumer: inout Consumer) where Self == Consumer.Root, Consumer: HashableKeyPathConsumer {
                consumer.addHashableKeyPath(\.bar)
                consumer.addHashableKeyPath(\.bar2)
                consumer.addHashableKeyPath(\.bar3)
            }

            let bar: String
            let bar2: String
            private let bar3: String

            init(bar: String, bar2: String, bar3: String) {
                self.bar = bar
                self.bar2 = bar2
                self.bar3 = bar3
            }
        }

        let foo1 = Foo(bar: "bar", bar2: "bar2", bar3: "bar3")
        let foo2 = Foo(bar: "bar", bar2: "bar2", bar3: "bar3")
        let foo3 = Foo(bar: "bar2", bar2: "bar2", bar3: "bar3")
        let foo4 = Foo(bar: "bar2", bar2: "bar", bar3: "bar3")

        XCTAssertEqual(foo1, foo1)
        XCTAssertEqual(foo1, foo2)
        XCTAssertEqual(foo1.hashValue, foo2.hashValue)
        XCTAssertNotEqual(foo1, foo3)
        XCTAssertNotEqual(foo1.hashValue, foo3.hashValue)
        XCTAssertNotEqual(foo1, foo4)
        XCTAssertNotEqual(foo1.hashValue, foo4.hashValue)

        XCTAssertEqual(foo2, foo2)
        XCTAssertNotEqual(foo2, foo3)
        XCTAssertNotEqual(foo2.hashValue, foo3.hashValue)
        XCTAssertNotEqual(foo2, foo4)
        XCTAssertNotEqual(foo2.hashValue, foo4.hashValue)

        XCTAssertEqual(foo3, foo3)
        XCTAssertNotEqual(foo3, foo4)
        XCTAssertNotEqual(foo3.hashValue, foo4.hashValue)

        XCTAssertEqual(foo4, foo4)
    }

}