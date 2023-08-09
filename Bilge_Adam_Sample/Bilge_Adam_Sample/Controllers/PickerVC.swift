//
//  VC1.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 1.08.2023.
//

import UIKit
import TinyConstraints


struct City {
    var name:String
    var states:[String]
}

class PickerVC: UIViewController {
    
    //MARK: --Picker içerisine tanımlayacağımız veri
    
    var data:[City] = [City(name: "Ankara", states: ["Mamak","Kızılay","Çankaya"]),
                       City(name: "İstanbul", states: ["Kadıköy","Sarıyer","Bakırköy"])]
    
    var allData = [[String]]()
    let cityArray = ["İstanbul","İzmir","Ankara","İstanbul","Trabzon","Sakarya","Adıyaman","Adana"]
    let stateArray = ["Kadıköy","Karşıyaka","Kızılay","Sürmene","Hendek","Kahta","Ceyhan"]
    
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

        self.allData.append(cityArray)
        self.allData.append(stateArray)
        self.view.backgroundColor = .white
        setupViews()
        
        
         cityArray.filter({ item in
            item == "İstanbul"
         })
    }
    
    //MARK: -- self.view'a tıklandığında editleme işlemini durdurur(Klavyeyi kapatır.)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func doneButtonTapped(){
        //MARK: -- PickerView'ın seçili satırının numarasını verir.
        let selectedCity = picker.selectedRow(inComponent: 0)
        let selectedState = picker.selectedRow(inComponent: 1)
        
        let cityName = allData[0][selectedCity]
        let stateName = allData[1][selectedState]
        
        let sum = cityName + " " + stateName
        
        
        txtCityName.text = sum
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
        
        return allData[component][row]
    }
    
    //MARK: -- PickerView içerisinde her bir satırdaki gösterilecek attiributedstring veriyi tanımlayan delegate(protocol) methodu.
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        let title = self.cityArray[row]
        let font = UIFont(name: "Poppins-SemiBold", size: 14)!
        let attrString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1) , NSAttributedString.Key.font:font] )

        return attrString
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
        return allData.count
    }
    
    //MARK: -- PickerView içerisinde hangi sütunda kaç tane satır olacağını belirleyen protocol methodu.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allData[component].count
    }
}
