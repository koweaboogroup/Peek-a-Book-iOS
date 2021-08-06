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
        var stringTotalPriceEstimation: String
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedTotalPriceEstimation = formatter.string(from: totalPriceEstimation as NSNumber) {
            stringTotalPriceEstimation = "\(formattedTotalPriceEstimation)"
        } else {
            stringTotalPriceEstimation = String(totalPriceEstimation)
        }

        
        if let lenderBooks = order.lenderBooks {
            for lenderBook in lenderBooks {
                totalPriceEstimation += lenderBook.price ?? 0
                
                bookListString.append(lenderBook.book?.title ?? "")
                bookListString.append(" - " + (lenderBook.book?.author ?? "") + "\n")
            }
        }

        switch self {
        case .courier:
            message = "Halo \(username),\nPenyewaan buku Anda dengan nomor order \(orderId) sudah diterima. Mohon konfirmasi kesesuaian detail penyewaan di bawah ini:\n\n*Detail Buku:*\n\(bookListString)\n\n*Durasi Penyewaan:*\n\(periodOfTime) Minggu\n\n*Metode Pengiriman:*\nKurir\n\n*Alamat:*\n\(fullAddress)\n\n*Estimasi Total Biaya:*\n\(stringTotalPriceEstimation)\n\nApakah detail di atas sudah sesuai? Jika sudah sesuai, saya ingin bertanya terkait pilihan pengiriman dan pembayaran yang menjadi preferensi Anda 🙏"
        case .selfPickup:
            message = "Halo \(username),\nPenyewaan buku Anda dengan nomor order \(orderId) sudah diterima. Mohon konfirmasi kesesuaian detail penyewaan di bawah ini:\n\n*Detail Buku:*\n\(bookListString)\n*Durasi Penyewaan:*\n\(periodOfTime) Minggu\n\n*Metode Pengiriman:*\nSelf Pickup\n\n*Estimasi Total Biaya:*\n\(stringTotalPriceEstimation)\n\nApakah detail di atas sudah sesuai? Jika sudah sesuai, saya ingin bertanya terkait pilihan pengiriman dan pembayaran yang menjadi preferensi Anda 🙏"
        case .cod:
            message = "Halo \(username),\nPenyewaan buku Anda dengan nomor order \(orderId) sudah diterima. Mohon konfirmasi kesesuaian detail penyewaan di bawah ini:\n\n*Detail Buku:*\n\(bookListString)\n*Durasi Penyewaan:*\n\(periodOfTime) Minggu\n\n*Metode Pengiriman:*\nCOD\n\n*Estimasi Total Biaya:*\n\(stringTotalPriceEstimation)\n\nApakah detail di atas sudah sesuai? Jika sudah sesuai, saya ingin bertanya terkait pilihan pengiriman dan pembayaran yang menjadi preferensi Anda 🙏"
        }
        
        let urlString = "https://api.whatsapp.com/send?phone=\(order.rent?.user?.phoneNumber ?? "")&text=\(message.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        
        return URL(string: urlString) ?? URL(fileURLWithPath: "")
    }
}
