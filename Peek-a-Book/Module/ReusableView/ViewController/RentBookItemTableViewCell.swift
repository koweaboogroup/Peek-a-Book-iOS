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
    @IBOutlet weak var rentDuration: UIButton!
    @IBOutlet weak var rentPrice: UILabel!
    
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
                        let lenderImage = Constant.Network.baseUrl + (lenderBooks[0].lender?.images?[0].url ?? "")
                        let sampleLenderBookImage = Constant.Network.baseUrl + (lenderBooks[0].images?[0].url ?? "")
                        lendersName.text = lenderBooks[0].lender?.name
                        bookTitle.text = lenderBooks[0].book?.title
                        imageProfileLenders.setImage(fromUrl: lenderImage)
                        bookImage.kf.setImage(with: URL(string: sampleLenderBookImage))
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
                rentDuration.setTitle("\(response.periodOfTime ?? 0) Minggu", for: .normal)
                
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
                        manipulateButtonView(button: warningButton, isHidden: false, text: "Tolak")
                        manipulateButtonView(button: activeButton, isHidden: true)
                        break
                    case RentStatus.shipping.getID():
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Diterima")
                        break
                    case RentStatus.ongoing.getID():
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Kembalikan")
                        break
                    case RentStatus.returning.getID():
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Menunggu Selesai", alpha: 0.5, isEnabled: false)
                        break
                    case RentStatus.done.getID():
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: true)
                        break
                    case RentStatus.unfinish.getID():
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: true)
                        break
                    default: break
                    }
                } else {
                    switch idStatusRent {
                    case RentStatus.waitingConfirmation.getID():
                        manipulateButtonView(button: warningButton, isHidden: false, text: "Tolak")
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Terima")
                        break
                    case RentStatus.awaiting.getID():
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Kirim Buku")
                    case RentStatus.shipping.getID():
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Menunggu Diterima", alpha: 0.5, isEnabled: false)
                        break
                    case RentStatus.ongoing.getID():
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Menunggu Kembali", alpha: 0.5, isEnabled: false)
                        break
                    case RentStatus.returning.getID():
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: false, text: "Diterima")
                        break
                    case RentStatus.done.getID():
                        manipulateButtonView(button: warningButton, isHidden: true)
                        manipulateButtonView(button: activeButton, isHidden: true)
                        break
                    case RentStatus.unfinish.getID():
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
                    //TODO: Tampilkan date picker
                    break
                case RentStatus.ongoing.getID():
                    //TODO: Ubah status aja
                    self.viewModel?.changeStatus(id: self.id, statusRent: RentStatus.returning.getID())
                    break
                default:
                    break
                }
            } else {
                switch idStatusRent {
                case RentStatus.waitingConfirmation.getID():
                    ConfirmationDialog.showAlertPositive(viewController: view, title: "Terima Penyewaan", subtitle: "Apakah anda setuju untuk menyewakan buku terhadap penyewa? \n\n Anda akan diarahkan ke WhatsApp untuk berkomunikasi dengan penyewa", positiveText: "Konfirmasi", negativeText: "Kembali") {
                        //TODO: OPEN WHATSAPP, CHANGE STATUS
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
}
