//
//  RegistroViewController.swift
//  ZooKids
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData

class RegistroViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nombre_usuario: UITextField!
    @IBOutlet weak var contrasenia: UITextField!
    @IBOutlet weak var contrasenia2: UITextField!
    @IBOutlet weak var fecha: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var femenino: UIImageView!
    @IBOutlet weak var masculino: UIImageView!
    var sexo = ""
    
    @IBAction func seleccionarImagen(sender: UITapGestureRecognizer) {
        let imagePickerCtrl = UIImagePickerController()
        imagePickerCtrl.sourceType = .PhotoLibrary
        imagePickerCtrl.delegate = self
        presentViewController(imagePickerCtrl, animated: true, completion: nil)
        
    }
   
    @IBAction func seleccionarSM(sender: UITapGestureRecognizer) {
        masculino.layer.borderColor = UIColor(red: 0.0, green: 122.0/255.00, blue: 1.0, alpha: 1.0).CGColor
        masculino.layer.borderWidth = 4
        femenino.layer.borderWidth = 0
        sexo = "masculino"
    }
    @IBAction func seleccionarSF(sender: UITapGestureRecognizer) {
        femenino.layer.borderColor = UIColor(red: 0.0, green: 122.0/255.00, blue: 1.0, alpha: 1.0).CGColor
        femenino.layer.borderWidth = 4
        masculino.layer.borderWidth = 0
        sexo = "femenino"

    }



    @IBAction func fecha_nacimiento(sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        datePickerView.locale = NSLocale(localeIdentifier: "es-es")
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(RegistroViewController.datePickerChangedValue), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    func datePickerChangedValue(sender: UIDatePicker){
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "es-es")
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        self.fecha.text = dateFormatter.stringFromDate(sender.date)
        self.fecha.resignFirstResponder()
    }
    
    @IBAction func nuevo_alumno(sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UIImageViewControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
