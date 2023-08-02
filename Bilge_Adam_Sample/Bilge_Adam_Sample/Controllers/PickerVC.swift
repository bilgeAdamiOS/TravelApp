//
//  VC1.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 1.08.2023.
//

import UIKit
import TinyConstraints

class PickerVC: UIViewController {
    
    //MARK: --Picker içerisine tanımlayacağımız veri
    let cityArray = ["İstanbul","İzmir","Ankara","Trabzon","Sakarya","Adıyaman","Adana"]
    
    //MARK: -- Picker üzerine ekleyeceğimiz ToolBar içindeki butonları tanımlar.
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
    
    //MARK: -- Toolbar içerisindeki boşluğu otomatik olarak ayarlayan BarButtonItem
    let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    
    //MARK: -- PickerView oluşturur. Delegate ve DataSource tanımlanması gerekir.
    private lazy var picker:UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    private lazy var txtCityName:CustomTextField = {
        let tf = CustomTextField()
        //MARK: -- Oluşturduğumuz PickerView'ı TextField'ın yeni klavyesi olarak tanımlar!
        tf.inputView = picker
        //MARK: --  TextField'a tanımlanmış PickerView için aksiyon alımasını sağlayan ve button bulunduran view.
        tf.inputAccessoryView = addToolBar()
        return tf
    }()

    //MARK: -- Controller içerisindeki view yüklendiğinde çalışan yaşam döngüsü methodu(Special Thanks to Şevval Çakıroğlu)
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setupViews()
    }
    
    //MARK: -- self.view'a tıklandığında editleme işlemini durdurur(Klavyeyi kapatır.)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func doneButtonTapped(){
        //MARK: -- PickerView'ın seçili satırının numarasını verir.
        let selectedItem = picker.selectedRow(inComponent: 0)
        let selectedText = cityArray[selectedItem]
        txtCityName.text = selectedText
        self.view.endEditing(true)
    }
    
    //MARK: -- UIToolBar ekleyip döndüren fonksiyon.
    private func addToolBar()->UIToolbar {
        let tb = UIToolbar()
        tb.sizeToFit()
        tb.setItems([space,doneButton], animated: false)
        return tb
    }
    
    func setupViews(){
        self.view.addSubviews(txtCityName)
        setupLayout()
    }
    
    private func setupLayout(){
        
        txtCityName.edgesToSuperview(excluding: [.bottom], insets:.left(16) + .right(16) + .top(16),usingSafeArea: true)
        txtCityName.height(50)
    }
    

}



extension PickerVC:UIPickerViewDelegate {
    
    //MARK: -- PickerView içerisinde her bir satırdaki gösterilecek string veriyi tanımlayan delegate(protocol) methodu.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.cityArray[row]
    }
    
    //MARK: -- PickerView içerisinde her satır değişiminde yapılan işlem.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let city = cityArray[row]
//        txtCityName.text = city
    }
}

extension PickerVC:UIPickerViewDataSource {
    
    //MARK: -- PickerView içerisinde kaç tane sütun olacağını berlirleyen protocol methodu.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //MARK: -- PickerView içerisinde hangi sütunda kaç tane satır olacağını belirleyen protocol methodu.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityArray.count
    }
}
