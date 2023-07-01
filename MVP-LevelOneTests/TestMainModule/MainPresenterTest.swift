//
//  MainPresenterTest.swift
//  MVP-LevelOneTests
//
//  Created by Даниил Тчанников on 29.06.2023.
//

import XCTest
@testable import MVP_LevelOne


class MockView: MainViewProtocol {
    func succes() {
    }
    
    func failure(error: Error) {
    }
}

class MockNetworkService: NetworkServiceProtocol {
    var comments: [Comment]!
    
    init() {}
    
    convenience init(comments: [Comment]?) {
        self.init()
        self.comments = comments
    }
    
    func getComments(completion: @escaping (Result<[Comment]?, Error>) -> Void) {
        if let comments = comments {
            completion(.success(comments))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}


final class MainPresenterTest: XCTestCase {
    
    var view: MockView!
    var presenter: MainPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var comments = [Comment]()
    

    override func setUpWithError() throws {
        let nav = UINavigationController()
        let assembly = AsselderModelBuilder()
        router = Router(navigationController: nav, assemblyBuilder: assembly)
    }

    override func tearDownWithError() throws {
        view = nil
        networkService = nil
        presenter = nil
    }
    
    func testGetSuccessComments() {
        let comment = Comment(postId: 1, id: 2, name: "Foo", email: "Baz", body: "Bar")
        comments.append(comment)
        
        view = MockView()
        networkService = MockNetworkService(comments: [comment])
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        var catchComments: [Comment]?
        
        networkService.getComments { result in
            switch result {
            case .success(let comments):
                catchComments = comments
            case .failure(let error):
                print(error)
            }
        }
        
        XCTAssertNotEqual(catchComments?.count, 0)
        XCTAssertEqual(catchComments?.count, comments.count)
    }
    
    func testGetFailureComments() {
        let comment = Comment(postId: 1, id: 2, name: "Foo", email: "Baz", body: "Bar")
        comments.append(comment)
        
        view = MockView()
        networkService = MockNetworkService()
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        var catchError: Error?
        
        networkService.getComments { result in
            switch result {
            case .success(let comments):
                print(comments)
            case .failure(let error):
                catchError = error
            }
        }
        
        XCTAssertNotNil(catchError)
    }
}
