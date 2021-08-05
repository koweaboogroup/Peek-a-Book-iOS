//
//  BookCatalogueService.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 05/08/21.
//

import Alamofire

class BookCatalogueService {
    static func getBookCatalogue(successCompletion: @escaping (BookCatalogue) -> Void, failCompletion: @escaping (AFError) -> Void) {
        BaseRequest.get(router: BookCatalogueRouter.get) { request in
            request.responseDecodable(of: BookCatalogue.self) { response in
                switch response.result {
                case .success(let bookCatalogue):
                    successCompletion(bookCatalogue)
                case .failure(let error):
                    failCompletion(error)
                }
                
            }
        }
    }
}
