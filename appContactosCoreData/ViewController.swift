//
//  ViewController.swift
//  appContactosCoreData
//
//  Created by Mac19 on 13/05/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var contactos = [Contacto]()
    var index:Int?
    
    // Conexión al contexto de BD
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var contact:Contacto?



    @IBOutlet weak var tablaContactos: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Leer Datso de COreData
        cargarCoreData()
        tablaContactos.reloadData()
        tablaContactos.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        tablaContactos.delegate = self
        tablaContactos.dataSource = self
    }


    @IBAction func addContact(_ sender: Any) {
        let alerta = UIAlertController(title: "Agregar Contacto", message: "Datos del contacto", preferredStyle: .alert)
        let accionAceptar = UIAlertAction(title: "Añadir", style: .default) { (_) in
            // Crear objeto contacto
            
            guard let nombreText = alerta.textFields?.first?.text else{return}
            guard let telefonoNum = Int64(alerta.textFields?[1].text ?? "0000000000") else{return}
            guard let direccion = alerta.textFields?[2].text else{return}
            let imagenTemp = UIImageView(image: #imageLiteral(resourceName: "llamada.png"))
            
            let nuevo = Contacto(context:self.contexto)
            nuevo.nombre = nombreText
            nuevo.telefono = telefonoNum
            nuevo.direccion = direccion
            nuevo.imagen = imagenTemp.image!.pngData()

            self.contactos.append(nuevo)
            
            self.guardarContacto()
            
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
            telefono.keyboardType = .numberPad
        }
        
        alerta.addTextField { (direccion) in
            direccion.placeholder = "Direccioón"
        }
        
        present(alerta, animated: true)
    }
    
    func guardarContacto(){
        do {
            try contexto.save()
            print("correcto")
        } catch let error as NSError {
            print("Error al guardar: \(error.localizedDescription)")
        }
    }
    
    func cargarCoreData(){
        let fetchRequest: NSFetchRequest <Contacto> = Contacto.fetchRequest()
        
        do {
            contactos = try contexto.fetch(fetchRequest)
        } catch  {
            print("error al cargar contactos del coreData: \(error.localizedDescription)")
        }
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
        self.index = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editarViewController" {
            let objController = segue.destination as! detalleViewController
            objController.recibirContacto = contact
            objController.index = self.index
        }
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accionDelete = UIContextualAction(style: .normal, title: "") { (_,_,_) in
            print("borrar")
            
            self.contexto.delete(self.contactos[indexPath.row])
            self.contactos.remove(at:indexPath.row)
            
            self.guardarContacto()
            self.tablaContactos.reloadData()
        
        }
        accionDelete.image = UIImage(named: "borrar.png")
        
        return UISwipeActionsConfiguration(actions: [accionDelete])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accionCall = UIContextualAction(style: .normal, title: "") { (_,_,_) in
            print("llamada")
        
        }
        accionCall.image = UIImage(named: "llamada.png")
        
        let accionSmS = UIContextualAction(style: .normal, title: "") { (_,_,_) in
            print("mensaje")
        
        }
        accionSmS.image = UIImage(named: "mensaje.png")
        
        
        return UISwipeActionsConfiguration(actions: [accionCall,accionSmS])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaContactos.dequeueReusableCell(withIdentifier: "celda", for:indexPath) as! ContactTableViewCell
        cell.nombreContacto.text = contactos[indexPath.row].nombre
        cell.telefonoContacto.text = "📞 \(contactos[indexPath.row].telefono)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

