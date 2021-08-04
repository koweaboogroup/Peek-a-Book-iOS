//
//  BookService.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 01/08/21.
//

import Foundation
import Alamofire

///TODO : UBAH SESUAI RESPONSENYA RIFKI
class BookService {
    static func getBookDetail(bookRequest: BookRequest, successCompletion: @escaping (Book?) -> Void, failCompletion: @escaping (AFError) -> Void) {
         
        BaseRequest.post(router: BookRouter.post(bookRequest)) { request in
            request.responseDecodable(of: Book.self) { response in
                
                switch response.result {
                case .success(let bookResponse):
                    successCompletion(bookResponse)
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
     }
     
    static func getListBook(successCompletion: @escaping ([Book]) -> Void, failCompletion: @escaping (AFError) -> Void){
        
        BaseRequest.get(router: BookRouter.get) { request in
            request.responseDecodable(of: Book.self) { response in
                
                switch response.result {
                case .success(let bookResponse):
                    successCompletion([bookResponse])
                case .failure(let error):
                    failCompletion(error)
                }
            }
        }
        
    }
    
}
