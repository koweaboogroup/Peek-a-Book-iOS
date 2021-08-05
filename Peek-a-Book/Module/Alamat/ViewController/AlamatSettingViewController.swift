//
//  AlamatSettingViewController.swift
//  Peek-a-Book
//
//  Created by Gede Wicaksana on 03/08/21.
//

import UIKit

class AlamatSettingViewController: UIViewController {

    @IBOutlet weak var kecamatanTextField: UITextField!
    @IBOutlet weak var kelurahanTextField: UITextField!
    @IBOutlet weak var kotaTextField: UITextField!
    @IBOutlet weak var provinsiTextField: UITextField!
    @IBOutlet weak var jalanTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //contoh binding
        
        // Do any additional setup after loading the view.
    }
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        if checkButton.imageView?.image == UIImage(named: "checkmark"){
            checkButton.imageView?.image = UIImage(named: "")
            removeAllAlamat()
        }
        else{
            checkButton.imageView?.image = UIImage(named: "checkmark")
            insertAllAlamat()
        }
    }
    
    func insertAllAlamat(){
        let user = DataManager.shared.getUser()
        kecamatanTextField.text = user?.kecamatan
        kelurahanTextField.text = user?.kelurahan
        kotaTextField.text = user?.kota
        provinsiTextField.text = user?.provinsi
        jalanTextField.text = user?.alamat
    }
    
    func removeAllAlamat(){
        kecamatanTextField.text = ""
        kelurahanTextField.text = ""
        kotaTextField.text = ""
        provinsiTextField.text = ""
        jalanTextField.text = ""
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
