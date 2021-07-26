//
//  MainBaseCoordinator.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 26/07/21.
//

import Foundation

protocol MainBaseCoordinator: Coordinator {
    var booksCoordinator: BooksBaseCoordinator { get }
    var profileCoordinator: ProfileCoordinator { get }
    func moveTo(flow: AppFlow)
}

protocol BooksBaseCoordinated {
    var coordinator: BooksBaseCoordinator? { get }
}

protocol ProfileBaseCoordinated {
    var coordinator: ProfileBaseCoordinator? { get }
}
