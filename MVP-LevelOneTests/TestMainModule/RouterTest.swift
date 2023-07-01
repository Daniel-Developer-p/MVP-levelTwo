//
//  RouterTest.swift
//  MVP-LevelOneTests
//
//  Created by Даниил Тчанников on 01.07.2023.
//

import XCTest
@testable import MVP_LevelOne

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

final class RouterTest: XCTestCase {

    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let assembly = AsselderModelBuilder()
    
    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, assemblyBuilder: assembly)
    }

    override func tearDownWithError() throws {
        router = nil
    }
    
    
    func testRouter() {
        router.showDetail(comment: nil)
        let detailViewController = navigationController.presentedVC
        XCTAssertTrue(detailViewController is DetailViewController)
    }
}
