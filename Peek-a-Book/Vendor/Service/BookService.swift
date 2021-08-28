//
//  BookService.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 01/08/21.
//

import Foundation
import Alamofire

class BookService {
    static func getBookDetail(id: String, successCompletion: @escaping (LenderBook?) -> Void, failCompletion: @escaping (AFError) -> Void) {
        
        BaseRequest.get(router: BookRouter.get(id: id)) { request in
            request.responseDecodable(of: [LenderBook].self) { response in
                
                switch response.result {
                case .success(let bookResponse):
                    successCompletion(bookResponse[0])
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
    }
    
    static func getListBook(successCompletion: @escaping ([LenderBook]) -> Void, failCompletion: @escaping (AFError) -> Void) {
        
        BaseRequest.get(router: BookListRouter.get) { request in
            request.responseDecodable(of: [LenderBook].self) { response in
                
                switch response.result {
                case .success(let bookResponse):
                    successCompletion(bookResponse)
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
    }
    
    static func getListBook(query: String, successCompletion: @escaping ([LenderBook]) -> Void, failCompletion: @escaping (AFError) -> Void){
        
        BaseRequest.get(router: BookListRouter.getSearch(query: query)) { request in
            request.responseDecodable(of: [LenderBook].self) { response in
                
                switch response.result {
                case .success(let bookResponse):
                    successCompletion(bookResponse)
                case .failure(let error):
                    debugPrint(error)
                    failCompletion(error)
                }
            }
        }
    }
    
    static func getBookByTitle(title: String, successCompletion: @escaping(BookResponse) -> Void, failCompletion: @escaping(AFError) -> Void, emptyDataCompletion: @escaping() -> Void) {
        BaseRequest.get(router: BookRouter.getByTitle(title: title)) { request in
            request.responseDecodable(of: [BookResponse].self) { response in
                switch response.result {
                case .success(let bookResponse):
                    if !bookResponse.isEmpty {
                        successCompletion(bookResponse[0])
                    } else {
                        emptyDataCompletion()
                    }
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
        
    }
    
    static func addBook(bookRequest: [String: String], successCompletion: @escaping(Int) -> Void, failCompletion: @escaping(AFError) -> Void) {
        BaseRequest.post(router: BookRouter.addBook(bookRequest: bookRequest)) { request in
            request.responseDecodable(of: BookResponse.self) { response in
                switch response.result {
                case .success(let bookResponse):
                    successCompletion(bookResponse.id ?? -1)
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
    }
    
}
