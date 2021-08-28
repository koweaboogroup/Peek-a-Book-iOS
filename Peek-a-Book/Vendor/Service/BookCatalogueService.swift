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
    
    static func addBookIntoCatalogue(lenderBookRequest: LenderBookRequest, successCompletion: @escaping () -> Void, failCompletion: @escaping (AFError) -> Void) {
        BaseRequest.post(router: BookCatalogueRouter.addBookIntoCatalogue(lenderBookRequest: lenderBookRequest)) { request in
            request.responseDecodable(of: LenderBook.self) { response in
                switch response.result {
                case .success(_):
                    successCompletion()
                case .failure(let error):
                    debugPrint("nih catalog", error)
                    failCompletion(error)
                }
            }
        }
    }
    
    static func addBookIntoCatalogueWithImage(image: Data, lenderBookRequest: LenderBookRequest, successCompletion: @escaping () -> Void, failCompletion: @escaping (AFError) -> Void) {
        guard let body = try? JSONEncoder().encode(lenderBookRequest) else { return }
        
        BaseRequest.upload(file: image, body: body) { response in
            switch response.result {
            case .success(_):
                successCompletion()
            case .failure(let error):
                failCompletion(error)
            }
        }
    }
}
