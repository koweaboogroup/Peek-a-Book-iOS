//
//  InsertBookViewController.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 23/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class InsertBookViewController: UIViewController {

    // MARK: - Variable (IBOutlet)
    
    @IBOutlet private weak var bookTitleTextField: UITextField!
    @IBOutlet private weak var isbnTextField: UITextField!
    @IBOutlet private weak var totalPageTextField: UITextField!
    @IBOutlet private weak var rentCostTextField: UITextField!
    
    @IBOutlet private weak var pickerView: UIPickerView!
    
    @IBOutlet private weak var textFieldsContainer: UIView!
    @IBOutlet private weak var pickerViewContainer: UIView!
    
    @IBOutlet private weak var pickerTitleLabel: UILabel!
    
    @IBOutlet private weak var bookConditionButton: UIButton!
    @IBOutlet private weak var bookGenreButton: UIButton!
    @IBOutlet private weak var bookLanguageButton: UIButton!
    @IBOutlet private weak var addToCatalogueButton: UIButton!
    @IBOutlet private weak var imagePickerButton: UIButton!
    
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    
    // MARK: - Variable (private)
    
    private var bookTitle = ""
    private var isbn = ""
    private var bookCondition = 0
    private var genre = 0
    private var language = 0
    private var totalPages = 0
    private var rentCost = 0
    private var bookId: Int?
    private var image: Data?
    
    private var disposeBag = DisposeBag()
    private var insertBookViewModel = InsertBookViewModel()
    
    private var pickerItems: PublishSubject<[Int]> = PublishSubject()
    private var pickerType: PickerType = .bookCondition
    private var imagePicker: ImagePicker?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tambah Buku"

        setupRx()
        
        setupUI()
        
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Function (IBAction)
    
    @IBAction private func addToCatalogueBtnPressed(_ sender: UIButton) {
        insertBookViewModel.addBookToCatalogue(title: bookTitle, isbn: isbn, genre: genre, bookId: bookId, bookCondition: bookCondition, totalPages: totalPages, language: BookLanguage(rawValue: language)?.getTitle() ?? "", rentCost: rentCost, image: image ?? Data()) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction private func imagePickerViewPressed(_ sender: UIButton) {
        imagePicker?.present(from: sender)
    }
    
    @IBAction private func bookConditionBtnPressed(_ sender: UIButton) {
        if bookCondition > 0 {
            pickerView.selectRow((BookCondition(rawValue: bookCondition)?.rawValue ?? -1) - 1, inComponent: 0, animated: false)
        } else {
            pickerView.selectRow(0, inComponent: 0, animated: false)
        }
        
        setupPickerView(pickerType: .bookCondition)
    }
    
    @IBAction private func bookGenreBtnPressed(_ sender: UIButton) {
        if genre > 0 {
            pickerView.selectRow((BookGenre(rawValue: genre)?.rawValue ?? -1) - 1, inComponent: 0, animated: false)
        } else {
            pickerView.selectRow(0, inComponent: 0, animated: false)
        }
        
        setupPickerView(pickerType: .bookGenre)
    }
    
    @IBAction private func bookLanguage(_ sender: UIButton) {
        if language > 0 {
            pickerView.selectRow((BookLanguage(rawValue: language)?.rawValue ?? -1) - 1, inComponent: 0, animated: false)
        } else {
            pickerView.selectRow(0, inComponent: 0, animated: false)
        }
        
        setupPickerView(pickerType: .bookLanguage)
    }
    
    @IBAction private func donePickerBtnPressed(_ sender: UIButton) {
        pickerViewContainer.isHidden = true
        
        switch pickerType {
        case .bookCondition:
            if bookCondition == 0 {
                assignPickerModel(0)
            }
        case .bookGenre:
            if genre == 0 {
                assignPickerModel(0)
            }
        case .bookLanguage:
            if language == 0 {
                assignPickerModel(0)
            }
        }
    }
    
    // MARK: - Function (private)
    
    private func setupPickerView(pickerType: PickerType) {
        pickerViewContainer.isHidden = false
        self.pickerType = pickerType
        pickerItems.onNext(pickerType.getPickerItems())
        pickerTitleLabel.text = pickerType.getTitle()
    }
    
    private func setupRx() {
        
        insertBookViewModel.loading
            .bind(to: loadingView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        insertBookViewModel.loading
            .map { loading in
                return !loading
            }
            .bind(to: loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        insertBookViewModel.loading.onNext(false)
        
        bookTitleTextField.rx.text
            .map {
                let bookTitle = $0?.trimmingCharacters(in: .whitespaces) ?? ""
                self.bookTitle = bookTitle
                return bookTitle
            }
            .bind(to: insertBookViewModel.bookTitle)
            .disposed(by: disposeBag)
        
        isbnTextField.rx.text
            .map {
                let isbn = $0?.trimmingCharacters(in: .whitespaces) ?? ""
                self.isbn = isbn
                return isbn
            }
            .bind(to: insertBookViewModel.isbn)
            .disposed(by: disposeBag)
        
        pickerItems
            .bind(to: pickerView.rx.itemTitles) { (row, element) in
                switch self.pickerType {
                case .bookCondition:
                    return BookCondition(rawValue: element)?.getTitle()
                case .bookGenre:
                    return BookGenre(rawValue: element)?.getTitle()
                case .bookLanguage:
                    return BookLanguage(rawValue: element)?.getTitle()
                }
            }
            .disposed(by: disposeBag)
        
        pickerView.rx.itemSelected
            .subscribe(onNext: { (row, _) in
                self.assignPickerModel(row)
            })
            .disposed(by: disposeBag)
            
        insertBookViewModel.isbn
            .bind(to: isbnTextField.rx.text)
            .disposed(by: disposeBag)
        
        insertBookViewModel.genre
            .map({ genre in
                BookGenre(rawValue: genre)?.getTitle() ?? ""
            })
            .bind(to: bookGenreButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        totalPageTextField.rx.text
            .map {
                self.totalPages = Int($0 ?? "0") ?? 0
                return self.totalPages
            }
            .bind(to: insertBookViewModel.totalPages)
            .disposed(by: disposeBag)
        
        rentCostTextField.rx.text
            .map {
                self.rentCost = Int($0 ?? "0") ?? 0
                return self.rentCost
            }
            .bind(to: insertBookViewModel.rentCost)
            .disposed(by: disposeBag)
        
        insertBookViewModel.isAllTextFieldsFilled()
            .bind(to: addToCatalogueButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        insertBookViewModel.isAllTextFieldsFilled()
            .map {
                $0 ? 1 : 0.5
            }
            .bind(to: addToCatalogueButton.rx.alpha)
            .disposed(by: disposeBag)
    }
    
    private func assignPickerModel(_ row: Int) {
        var title: String
        let id = row + 1
        
        switch self.pickerType {
        case .bookCondition:
            title = BookCondition(rawValue: id)?.getTitle() ?? ""
            self.bookConditionButton.setTitle(title, for: .normal)
            self.bookCondition = id
            self.insertBookViewModel.bookCondition.onNext(id)
        case .bookGenre:
            title = BookGenre(rawValue: id)?.getTitle() ?? ""
            self.genre = id
            self.insertBookViewModel.genre.onNext(id)
        case .bookLanguage:
            title = BookLanguage(rawValue: id)?.getTitle() ?? ""
            self.bookLanguageButton.setTitle(title, for: .normal)
            self.language = id
            self.insertBookViewModel.language.onNext(title)
        }
    }
    
    private func setupUI() {
        textFieldsContainer.layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 2, blur: 5, spread: 0)
        
        bookTitleTextField.delegate = self
        isbnTextField.delegate = self
        
        imagePicker = ImagePicker(presentationController: self, delegate: self)
    }

}

extension InsertBookViewController: UITextFieldDelegate {
    
    // MARK: - Function (UITextFieldDelegate)
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == bookTitleTextField {
            let bookTitle = bookTitleTextField.text?.trimmingCharacters(in: .whitespaces).capitalized ?? ""
            bookTitleTextField.text = bookTitle
            
            insertBookViewModel.getBookByTitle(title: bookTitle) { bookId in
                self.isbnTextField.isEnabled = false
                self.isbnTextField.alpha = 0.5
                
                self.bookGenreButton.isEnabled = false
                self.bookGenreButton.alpha = 0.5
                
                self.bookId = bookId
            } errorCompletion: {
                self.isbnTextField.becomeFirstResponder()
            }
        }
        
        return true
    }
    
}

extension InsertBookViewController {
    
    // MARK: - Enum
    
    private enum BookGenre: Int {
        case fiction = 1
        case nonFiction = 2
        
        func getTitle() -> String {
            switch self {
            case .fiction:
                return "Fiksi"
            case .nonFiction:
                return "Non Fiksi"
            }
        }
    }
    
    private enum BookCondition: Int {
        case likeNew = 1
        case good = 2
        case readable = 3
        case oldBook = 4
        
        func getTitle() -> String {
            switch self {
            case .likeNew:
                return "Seperti Baru"
            case .good:
                return "Baik"
            case .readable:
                return "Dapat Dibaca"
            case .oldBook:
                return "Buku Lama"
            }
        }
    }
    
    private enum BookLanguage: Int {
        case indonesian = 1
        case english = 2
        case others = 3
        
        func getTitle() -> String {
            switch self {
            case .indonesian:
                return "Indonesia"
            case .english:
                return "Inggris"
            case .others:
                return "Lainnya"
            }
        }
    }
    
    private enum PickerType {
        case bookCondition, bookGenre, bookLanguage
        
        func getPickerItems() -> [Int] {
            switch self {
            case .bookCondition:
                return [1, 2, 3, 4]
            case .bookGenre:
                return [1, 2]
            case .bookLanguage:
                return [1, 2, 3]
            }
        }
        
        func getTitle() -> String {
            switch self {
            case .bookCondition:
                return "Kondisi Buku"
            case .bookGenre:
                return "Genre"
            case .bookLanguage:
                return "Bahasa"
            }
        }
    }
    
}

extension InsertBookViewController: ImagePickerDelegate {
    
//    MARK: - Function (ImagePickerDelegate)
    
    func didSelect(image: UIImage?) {
        if let image = image {
            imagePickerButton.setTitle("", for: .normal)
            imagePickerButton.setBackgroundImage(image, for: .normal)
            insertBookViewModel.image.onNext(image)
            self.image = image.jpegData(compressionQuality: 1.0) ?? Data()
        }
    }
    
}
