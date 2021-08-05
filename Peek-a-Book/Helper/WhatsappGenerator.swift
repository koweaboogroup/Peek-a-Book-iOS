//
//  WhatsappGenerator.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 06/08/21.
//

import Foundation

enum WhatsappGenerator {
    case courier, selfPickup, cod
    
    func getURL(order: Order) -> URL {
        var message: String
        
        let username = order.rent?.user?.username ?? ""
        let orderId = order.id ?? 0
        let periodOfTime = order.rent?.periodOfTime ?? -1
        
        let fullAddress = "\(order.rent?.user?.alamat ?? "")\n\(order.rent?.user?.kelurahan ?? "")\n\(order.rent?.user?.kecamatan ?? "")\n\(order.rent?.user?.kota ?? ""), Indonesia"
        
        var bookListString = ""
        var totalPriceEstimation = 0
        
        if let lenderBooks = order.lenderBooks {
            for lenderBook in lenderBooks {
                totalPriceEstimation += lenderBook.price ?? 0
                
                bookListString.append(lenderBook.book?.title ?? "")
                bookListString.append(" - " + (lenderBook.book?.author ?? "") + "\n")
            }
        }

        switch self {
        case .courier:
            message = "Halo \(username),\nPenyewaan buku Anda dengan nomor order \(orderId) sudah diterima. Mohon konfirmasi kesesuaian detail penyewaan di bawah ini:\n\nDetail Buku:\n\(bookListString)Durasi Penyewaan:\n\(periodOfTime) Minggu\nMetode Pengiriman:\nKurir\nAlamat:\n\(fullAddress)\nTotal Biaya:\n\(totalPriceEstimation)\n\nApakah detail di atas sudah sesuai? Jika sudah sesuai, saya ingin bertanya terkait pilihan pengiriman dan pembayaran yang menjadi preferensi Anda 🙏"
        case .selfPickup:
            message = "Halo \(username),\nPenyewaan buku Anda dengan nomor order \(orderId) sudah diterima. Mohon konfirmasi kesesuaian detail penyewaan di bawah ini:\nDetail Buku:\n\(bookListString)Durasi Penyewaan:\n\(periodOfTime) Minggu\nMetode Pengiriman:\nSelf Pickup\nTotal Biaya:\n\(totalPriceEstimation)\nApakah detail di atas sudah sesuai? Jika sudah sesuai, saya ingin bertanya terkait pilihan pengiriman dan pembayaran yang menjadi preferensi Anda 🙏"
        case .cod:
            message = "Halo \(username),\nPenyewaan buku Anda dengan nomor order \(orderId) sudah diterima. Mohon konfirmasi kesesuaian detail penyewaan di bawah ini:\nDetail Buku:\n\(bookListString)Durasi Penyewaan:\n\(periodOfTime) Minggu\nMetode Pengiriman:\nCOD\nTotal Biaya:\n\(totalPriceEstimation)\nApakah detail di atas sudah sesuai? Jika sudah sesuai, saya ingin bertanya terkait pilihan pengiriman dan pembayaran yang menjadi preferensi Anda 🙏"
        }
        
        let urlString = "https://api.whatsapp.com/send?phone=\(order.rent?.user?.phoneNumber ?? "")&text=\(message.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        
        return URL(string: urlString) ?? URL(fileURLWithPath: "")
    }
}
