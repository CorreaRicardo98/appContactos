//
//  detalleViewController.swift
//  appContactosCoreData
//
//  Created by Mac19 on 18/05/21.
//

import UIKit
import CoreData

class detalleViewController: UIViewController {
    var recibirContacto:Contacto?
    var index:Int?
    
    var contactos = [Contacto]()
    
    // Conexión al contexto de BD
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var contact:Contacto?
    

    @IBOutlet weak var direccionTextField: UITextField!
    @IBOutlet weak var telefonoTextField: UITextField!
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var imagenPerson: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarCoreData()
        //MARK:-gestura de imagenes
        let gesturas = UITapGestureRecognizer(target: self, action: #selector(clickImagen))
        gesturas.numberOfTapsRequired = 1
        gesturas.numberOfTouchesRequired = 1
        
        imagenPerson.addGestureRecognizer(gesturas)
        imagenPerson.isUserInteractionEnabled = true
        
        self.telefonoTextField.text = "\(recibirContacto!.telefono)"
        self.nombreTextField.text = recibirContacto?.nombre
        self.direccionTextField.text = recibirContacto?.direccion
    }
    
    @objc func clickImagen(gestura: UITapGestureRecognizer){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    

    @IBAction func takePhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .savedPhotosAlbum
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
        
    }
    @IBAction func saveButton(_ sender: Any) {
        
        do {
           // contactos[index!].setValue(nombreTextField.text,forkey:"nombre")
           // contactos[index!].setValue(Int64(telefonoTextField.text!),forkey:"telefono")
           // contactos[index!].setValue(direccionTextField.text,forkey:"direccion")
           // contactos[index!].setValue(imagenPerson.image?.pngData(),forkey:"imagen")
            

            try self.contexto.save()
            print("guardado correctamente")
        } catch  {
            print("error: \(error.localizedDescription)")
        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}

extension detalleViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imagenPerson.image = selectedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
