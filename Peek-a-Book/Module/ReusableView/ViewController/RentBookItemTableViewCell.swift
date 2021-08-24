//
//  RentBookItemView.swift
//  Peek-a-Book
//
//  Created by Muhammad Rifki Wildadi on 04/08/21.
//

import UIKit
import SafariServices

class RentBookItemTableViewCell: UITableViewCell{
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var imageProfileLenders: CircleImageView!
    @IBOutlet weak var lendersName: UILabel!
    @IBOutlet weak var statusRent: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookItemMoreThanOne: UILabel!
    @IBOutlet weak var rentDuration: UILabel!
    @IBOutlet weak var rentPrice: UILabel!
    @IBOutlet weak var rentDeadline: UILabel!
    
    @IBOutlet weak var warningButton: UIButton!
    @IBOutlet weak var activeButton: UIButton!
    
    private var id: Int = 0
    private var isFromRenter = true
    private var idStatusRent: Int? = 0
    private var shippingMethod = ""
    
    private var viewModel: RentViewModel?
    private var viewController: UIViewController?
    
    func setViewModel(viewModel: RentViewModel) {
        self.viewModel = viewModel
    }
    
    func setViewController(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    override func awakeFromNib() {
        rootView.layer.applyShadow(
            color: .black,
            alpha: 0.1,
            x: 0,
            y: 6,
            blur: 30,
            spread: 0
        )
    }
    
    var response : Rent? {
        didSet {
            if let response = response {
                id = response.id ?? 0
                if let lenderBooks = response.lenderBooks {
                    if !lenderBooks.isEmpty {
                        if let imageLender =  lenderBooks[0].lender?.images, let imageBookSample = lenderBooks[0].images{
                            if !imageLender.isEmpty {
                                let lenderImage = Constant.Network.baseUrl + (imageLender[0].url ?? "")
                                imageProfileLenders.setImage(fromUrl: lenderImage)
                            }else {
                                imageProfileLenders.setBackgroundColor(color: #colorLiteral(red: 0.9058823529, green: 0.9568627451, blue: 1, alpha: 1))
                                imageProfileLenders.setPlaceHolderImage(image: UIImage(systemName: "person")!)
                            }
                            
                            if !imageBookSample.isEmpty {
                                let sampleLenderBookImage = Constant.Network.baseUrl + (imageBookSample[0].url ?? "")
                                bookImage.kf.setImage(with: URL(string: sampleLenderBookImage))
                            }else{
                                bookImage.image = UIImage(systemName: "book.fill")
                            }
                            
                        }
                        lendersName.text = lenderBooks[0].lender?.name
                        bookTitle.text = lenderBooks[0].book?.title
                    }
                }
                let countBooks = response.lenderBooks?.count ?? 0
                var price = 0
                isFromRenter = response.isFromRenter
                idStatusRent = response.status?.id
                shippingMethod = response.shippingMethods ?? ""
                
                if countBooks > 1 {
                    bookItemMoreThanOne.isHidden = false
                }else{
                    bookItemMoreThanOne.isHidden = true
                }
                
                bookItemMoreThanOne.text = "+\(countBooks - 1) buku lainnya"
                rentDuration.text = "\(response.periodOfTime ?? 0) Minggu"
                
                if let books = response.lenderBooks {
                    for item in books {
                        price += (item.price ?? 0)
                    }
                }
                
                rentPrice.text = "Rp \(price.toRupiah())"
                statusRent.text = response.status?.name
                
                if isFromRenter {
                    switch idStatusRent {
                    case RentStatus.awaiting.getID():
                        rentDeadline.isHidden = true
                        manipulateButtonView(button: warningButton, isHidden: false, text: "Batalkan")
                        manipulateButtonView(button: activeButton, isHidden: true)
                        break
                    case RentStatus.shipping.getID():
                        rentDeadline.isHidden = true
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Diterima")
                        break
                    case RentStatus.ongoing.getID():
                        if let date = response.updatedAt?.toDate() {
                            rentDeadline.isHidden = false
                            rentDeadline.text = "Kembalikan Sebelum \(calculateDeadline(date: date, duration: response.periodOfTime ?? 0))"
                        }
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Kembalikan")
                        break
                    case RentStatus.returning.getID():
                        rentDeadline.isHidden = false
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Menunggu Selesai", alpha: 0.5, isEnabled: false)
                        break
                    case RentStatus.done.getID():
                        rentDeadline.isHidden = true
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: true)
                        break
                    case RentStatus.unfinish.getID():
                        rentDeadline.isHidden = true
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: true)
                        break
                    default: break
                    }
                } else {
                    switch idStatusRent {
                    case RentStatus.waitingConfirmation.getID():
                        rentDeadline.isHidden = true
                        manipulateButtonView(button: warningButton, isHidden: false, text: "Tolak")
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Terima")
                        break
                    case RentStatus.awaiting.getID():
                        rentDeadline.isHidden = true
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Kirim Buku")
                    case RentStatus.shipping.getID():
                        rentDeadline.isHidden = true
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Menunggu Diterima", alpha: 0.5, isEnabled: false)
                        break
                    case RentStatus.ongoing.getID():
                        if let date = response.updatedAt?.toDate() {
                            rentDeadline.isHidden = false
                            rentDeadline.text = "Dikirim Kembali Sebelum \(calculateDeadline(date: date, duration: response.periodOfTime ?? 0))"
                        }
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Menunggu Kembali", alpha: 0.5, isEnabled: false)
                        break
                    case RentStatus.returning.getID():
                        if let date = response.updatedAt?.toDate() {
                            rentDeadline.isHidden = false
                            rentDeadline.text = "Dikirim Kembali Sebelum \(calculateDeadline(date: date, duration: 0))"
                        }
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Diterima")
                        break
                    case RentStatus.done.getID():
                        rentDeadline.isHidden = true
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: true)
                        break
                    case RentStatus.unfinish.getID():
                        rentDeadline.isHidden = true
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: true)
                        break
                    default: break
                    }
                }
            }
        }
    }
    
    @IBAction func activeButtonPressed(_ sender: UIButton) {
        if let view = viewController {
            if isFromRenter {
                switch idStatusRent {
                case RentStatus.shipping.getID():
                    viewModel?.showDatePicker.onNext(true)
                    viewModel?.selectedId.onNext(self.id)
                    break
                case RentStatus.ongoing.getID():
                    self.viewModel?.changeStatus(id: self.id, statusRent: RentStatus.returning.getID())
                    break
                default:
                    break
                }
            } else {
                switch idStatusRent {
                case RentStatus.waitingConfirmation.getID():
                    ConfirmationDialog.showAlertPositive(viewController: view, title: "Terima Penyewaan", subtitle: "Apakah anda setuju untuk menyewakan buku terhadap penyewa? \n\n Anda akan diarahkan ke WhatsApp untuk berkomunikasi dengan penyewa", positiveText: "Konfirmasi", negativeText: "Kembali") {
                        self.viewModel?.changeStatus(id: self.id, statusRent: RentStatus.awaiting.getID())
                        view.dismiss(animated: true, completion: nil)
                        let safariViewController = SFSafariViewController(url: WhatsappGenerator(rawValue: self.shippingMethod)!.getURL(order: self.response!))
                        view.present(safariViewController, animated: true, completion: nil)
                    } negativeCompletion: {
                        view.dismiss(animated: true, completion: nil)
                    }
                    break
                case RentStatus.awaiting.getID():
                    self.viewModel?.changeStatus(id: self.id, statusRent: RentStatus.shipping.getID())
                case RentStatus.returning.getID():
                    self.viewModel?.changeStatus(id: self.id, statusRent: RentStatus.done.getID())
                    break
                default:
                    break
                }
            }
        }
    }
    
    @IBAction func warningButtonPressed(_ sender: UIButton) {
        if let view = viewController {
            if !isFromRenter {
                ConfirmationDialog.showAlertNegative(viewController: view, title: "Tolak Penyewaan", subtitle: "Apakah Anda yakin menolak menyewakan buku terhadap penyewa?", positiveText: "Kembali", negativeText: "Tolak") {
                    view.dismiss(animated: true, completion: nil)
                } negativeCompletion: {
                    self.viewModel?.changeStatus(id: self.id, statusRent: RentStatus.unfinish.getID())
                    view.dismiss(animated: true, completion: nil)
                }
            } else {
                ConfirmationDialog.showAlertNegative(viewController: view, title: "Batalkan Penyewaan", subtitle: "Apakah Anda yakin membatalkan penyewaan?", positiveText: "Kembali", negativeText: "Batalkan") {
                    view.dismiss(animated: true, completion: nil)
                } negativeCompletion: {
                    self.viewModel?.changeStatus(id: self.id, statusRent: RentStatus.unfinish.getID())
                    view.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    private func manipulateButtonView(button: UIButton, isHidden: Bool, text: String? = "", alpha: CGFloat = 1, isEnabled: Bool = true){
        
        button.isHidden = isHidden
        button.setTitle(text, for: .normal)
        button.alpha = alpha
        button.isEnabled = isEnabled
    }
    
    private func calculateDeadline(date: Date, duration: Int) -> String {
        if let deadline = Calendar.current.date(byAdding: .weekOfMonth, value: duration, to: date){
            return deadline.toString(dateFormat: "yyyy-MM-dd hh:mm:ss", toFormat: "dd MMMM yyyy")
        }else{
            return ""
        }
    }
}
