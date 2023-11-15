//
//  EarthquakesView.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import Foundation
import UIKit
class EarthquakesView: UIViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var fechaFin: UITextField!
    @IBOutlet weak var fechaIni: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Properties
    var presenter: EarthquakesPresenter?
    private let datePickerIni = UIDatePicker()
    private let datePickerFin = UIDatePicker()
    private let datePicker = UIDatePicker()
    private var activeTextField: UITextField?
    private var features: [Feature] = []
    private let pageSize = 10
    private var currentPage = 0
    private var isLoadingData = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    @IBAction func closeSession(_ sender: Any) {
        
        let alert = UIAlertController(title: "Desea cerrar sesion?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            self.presenter!.goToLogin()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { _ in
        
        }))
        self.present(alert, animated: true, completion: nil)
    }
    private func setupDatePicker() {
        // Configurar los datePickers
        datePickerIni.datePickerMode = .date
        datePickerFin.datePickerMode = .date
        datePickerIni.preferredDatePickerStyle = .wheels
        datePickerFin.preferredDatePickerStyle = .wheels

        // Configurar las fechas por defecto
        let calendar = Calendar.current
        datePickerIni.date = calendar.date(byAdding: .day, value: -1, to: Date())! // Ayer
        datePickerFin.date = Date() // Hoy

        // Configurar la barra de herramientas
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dateDoneAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: true)

        // Asignar datePicker y toolbar a los textFields
        fechaIni.inputAccessoryView = toolbar
        fechaIni.inputView = datePickerIni
        fechaFin.inputAccessoryView = toolbar
        fechaFin.inputView = datePickerFin

        // Establecer fechas iniciales en los textFields
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        fechaIni.text = formatter.string(from: datePickerIni.date)
        fechaFin.text = formatter.string(from: datePickerFin.date)
        presenter?.searchEarthQaukes(fechaini: fechaIni.text!, fechafin: fechaFin.text!)
        // Agregar los delegados
        fechaIni.delegate = self
        fechaFin.delegate = self
    }

    @IBAction func searchEarthQuakes(_ sender: Any) {
        presenter?.searchEarthQaukes(fechaini: fechaIni.text!, fechafin: fechaFin.text!)
    }
    @objc private func dateDoneAction() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        if activeTextField == fechaIni {
            activeTextField?.text = formatter.string(from: datePickerIni.date)
        } else if activeTextField == fechaFin {
            activeTextField?.text = formatter.string(from: datePickerFin.date)
        }
        view.endEditing(true)
    }
}
// MARK: - extending LoginView to implement it's protocol
extension EarthquakesView: EarthquakesViewProtocol {
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
      
        }))
    
        self.present(alert, animated: true, completion: nil)
    }
    
    func setItemsTableview(feactures: [Feature]) {
        DispatchQueue.main.async {
            self.features = feactures
            self.tableView.reloadData()
        }
    }
    func spinnerOn(){
        self.spinner.isHidden = false
        self.spinner.startAnimating()
    }
    func spinnerOff(){
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
    }
}

extension EarthquakesView: UITableViewDataSource, UITableViewDelegate {
    
     func setupUI() {
        // Configurar la tabla
        tableView.dataSource = self
        tableView.delegate = self
        let earthquakesCell = String(describing: EarthquakesCell.self)
        tableView.register(UINib(nibName: earthquakesCell, bundle: nil), forCellReuseIdentifier: earthquakesCell)
         let nodataCell = String(describing: NodataCell.self)
         tableView.register(UINib(nibName: nodataCell, bundle: nil), forCellReuseIdentifier: nodataCell)
        // Cargar datos de demostración
        //loadDemoData()
        loadPage()
        setupDatePicker()
    }

    private func loadDemoData() {
            // Crear 1000 datos demo
            for i in 1...1000 {
                let feature = Feature(type: "Feature", properties: Properties(mag: Double(i), place: "Place \(i)", time: i, updated: i, tz: nil, url: "http://example.com", detail: "http://example.com", felt: nil, cdi: nil, mmi: nil, alert: nil, status: "status", tsunami: i % 2, sig: i, net: "net", code: "code", ids: "ids", sources: "sources", types: "types", nst: nil, dmin: nil, rms: Double(i), gap: nil, magType: "magType", title: "Title \(i)"), geometry: Geometry(type: "Point", coordinates: [Double(i), Double(i), Double(i)]), id: "\(i)")
                features.append(feature)
            }
        }

        private func loadPage() {
            // Asegurarse de que no se esté cargando otra página
            guard !isLoadingData else { return }

            isLoadingData = true

            // Calcular el rango de los datos a mostrar
            let startIndex = max(features.count - pageSize * (currentPage + 1), 0)
            let endIndex = features.count - pageSize * currentPage
            currentPage += 1

            let range = startIndex..<endIndex
            let pageData = Array(features[range])

            // Agregar nuevos datos al array existente
            self.features.append(contentsOf: pageData)
            tableView.reloadData()

            isLoadingData = false
        }

    // MARK: - UITableViewDataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 205
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if features.count == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NodataCell", for: indexPath) as? NodataCell else {
                        fatalError("Unable to dequeue Cell")}
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EarthquakesCell", for: indexPath) as? EarthquakesCell else {
                    fatalError("Unable to dequeue Cell")}
        
        let feature = features[indexPath.row]
        let profundidadString = feature.properties.nst != nil ? String(feature.properties.nst!) : "N/A" // Convierte a String, o usa "N/A" si es nil
        let mag = feature.properties.mag != nil ? String(feature.properties.mag!) : "N/A" // Convierte a String, o usa "N/A" si es nil
        let place = feature.properties.place != nil ? String(feature.properties.place!) : "N/A" // Convierte a String, o usa "N/A" si es nil
       
        cell.setDataCell(title: feature.properties.title, mag: mag, profundidad: profundidadString, place: place)
        return cell
    }

    // MARK: - UITableViewDelegate Methods

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == features.count - 1 && !isLoadingData {
            // Cargar más datos cuando el usuario llegue al final de la lista
            loadPage()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feature = features[indexPath.row]
        presenter?.goToEarthquakesDetail(feature: feature)
    }
}

extension EarthquakesView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        if let text = textField.text, !text.isEmpty {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            datePicker.date = formatter.date(from: text) ?? Date()
        } else {
            datePicker.date = Date()
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
}
