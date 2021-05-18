//
//  detalleViewController.swift
//  appContactosCoreData
//
//  Created by Mac19 on 18/05/21.
//

import UIKit

class detalleViewController: UIViewController {
    var recibirContacto:MiContacto?

    @IBOutlet weak var nombreTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        nombreTextField.text = recibirContacto?.nombre
    }
    

    @IBAction func takePhoto(_ sender: Any) {
        
    }
    @IBAction func saveButton(_ sender: Any) {
    }
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
