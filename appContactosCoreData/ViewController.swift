//
//  ViewController.swift
//  appContactosCoreData
//
//  Created by Mac19 on 13/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    var contactos = [MiContacto]()
    var contact:MiContacto?
    var prueba = MiContacto(nombre: "Luis", telefono: 4433360818, direccion: "hidalgo s/n")


    @IBOutlet weak var tablaContactos: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        contactos.append(prueba)
        tablaContactos.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        tablaContactos.delegate = self
        tablaContactos.dataSource = self
    }


    @IBAction func addContact(_ sender: Any) {
        let alerta = UIAlertController(title: "Agregar Contacto", message: "Datos del contacto", preferredStyle: .alert)
        let accionAceptar = UIAlertAction(title: "Añadir", style: .default) { (_) in
            print("se agrego contacto")
            guard let nombreText = alerta.textFields?.first?.text else{return}
            guard let telefonoNum = Int64(alerta.textFields?[1].text ?? "0000000000") else{return}
            guard let direccion = alerta.textFields?[2].text else{return}
            
            let nuevo = MiContacto(nombre: nombreText, telefono: telefonoNum, direccion: direccion)

            self.contactos.append(nuevo)
            
            self.tablaContactos.reloadData()
            
        }
        let accionCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alerta.addAction(accionAceptar)
        alerta.addAction(accionCancel)
        
        alerta.addTextField { (nombre) in
            nombre.placeholder = "Nombre"
        }
        
        alerta.addTextField { (telefono) in
            telefono.placeholder = "Telefono"
        }
        
        alerta.addTextField { (direccion) in
            direccion.placeholder = "Direccioón"
        }
        
        present(alerta, animated: true)
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactos.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tablaContactos.deselectRow(at: indexPath, animated: true)
        self.contact = contactos[indexPath.row]
        performSegue(withIdentifier: "editarViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editarViewController" {
            let objController = segue.destination as! detalleViewController
            objController.recibirContacto = contact
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaContactos.dequeueReusableCell(withIdentifier: "celda", for:indexPath) as! ContactTableViewCell
        cell.nombreContacto.text = contactos[indexPath.row].nombre
        cell.telefonoContacto.text = "📞 \(contactos[indexPath.row].telefono!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

