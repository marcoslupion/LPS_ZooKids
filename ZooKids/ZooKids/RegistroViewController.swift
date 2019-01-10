//
//  RegistroViewController.swift
//  ZooKids
//
//  Created by Jose F. Ruiz Zamora on 29/12/18.
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
    var imagenH: Bool = false
    var imagenM: Bool = false
    var fechaInsertar: NSDate!
    var profesor: Profesor!
    
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
        sexo = "H"
        
        imagenH = true
        imagenM = false
    }
    @IBAction func seleccionarSF(sender: UITapGestureRecognizer) {
        femenino.layer.borderColor = UIColor(red: 0.0, green: 122.0/255.00, blue: 1.0, alpha: 1.0).CGColor
        femenino.layer.borderWidth = 4
        masculino.layer.borderWidth = 0
        sexo = "M"
        
        imagenM = true
        imagenH = false

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
        fechaInsertar = sender.date
    }
    
    @IBAction func nuevo_alumno(sender: UIButton) {
        
        //Prueba date picker
        /*print(fecha_nacimiento_insertar.date)   //Tipo 2018-12-30 10:55:56 +0000
         let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
         let dd = calendar.component(.Day, fromDate: fecha_nacimiento_insertar.date)
         let mm = calendar.component(.Month, fromDate: fecha_nacimiento_insertar.date)
         let yy = calendar.component(.Year, fromDate: fecha_nacimiento_insertar.date)
         
         print("fecha = ",dd," / ",mm," / ",yy)*/
        
        //Campos vacíos = error
        if(nombre_usuario.text == "" || contrasenia.text == ""){
            //print("Usuario o contraseña vacío")
            //Añadir alert controller
            let alertController = UIAlertController(title: "¡Cuidado!", message: "Usuario o contraseña vacío", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        if(contrasenia.text != contrasenia2.text){
            //print("Contraseñas no coinciden")
            let alertController = UIAlertController(title: "¡Cuidado!", message: "Las contraseñas no coinciden", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return;
        }
        
        if(imagenH == false && imagenM == false){
            //print("Selecciona género")
            let alertController = UIAlertController(title: "¡Cuidado!", message: "Selecciona género", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        if(fechaInsertar == nil || fecha.text == ""){
            //print("Selecciona fecha")
            let alertController = UIAlertController(title: "¡Cuidado!", message: "Fecha vacía", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        //Cargar alumnos Core Data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequestAlumno = NSFetchRequest(entityName: "Alumno")
        
        do{
            let resultsAlumno = try managedContext.executeFetchRequest(fetchRequestAlumno)
            for alumno in resultsAlumno as! [Alumno]{
                //Si algún alumno coincide mostrar error
                if(nombre_usuario.text == alumno.nombre_usuario){
                    
                    //Añadir alert controller error: Alumno existe
                    let alertController = UIAlertController(title: "¡Cuidado!", message: "El alumno ya existe", preferredStyle: .Alert)
                    let cancelAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                    return
                }
            }
            
        }
        catch{
            print("error")
        }
        
        //Insertar alumno
        let entity = NSEntityDescription.entityForName("Alumno", inManagedObjectContext: managedContext)
        
        let alumno = Alumno(entity:entity!, insertIntoManagedObjectContext: managedContext)
        alumno.nombre_usuario = nombre_usuario.text!
        alumno.contrasenia = contrasenia.text!
        alumno.foto = imgView.image!
        alumno.sexo = sexo
        alumno.fecha_nacimiento = fechaInsertar
        
        //Asignar el alumno al profesor
        //TODO: Profe a añadir = Variable global de profesor
        //alumno.profesor=profesor
        
        
        
        do{
            try managedContext.save()
            //TODO: Añadir allert controller exito
            
            let alertController = UIAlertController(title: "Alumno añadido", message: "", preferredStyle: .Alert)
            let confirmAction = UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.Default, handler: ({
                (_) in
                self.cerrarAlertController()
                
            }))
            alertController.addAction(confirmAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            
        }
        catch{
            
            print("error")
        }
        
        print("Añadido alumno: Nombre = ",alumno.nombre_usuario, " ; pass = ",alumno.contrasenia," ; sexo = ",alumno.sexo," ; fecha = ",alumno.fecha_nacimiento.description)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        //profesor = Inicio_de_sesionViewController.getProfesor(self: Inicio_de_sesionViewController)
        
        
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
    
    func cerrarAlertController(){
        
        //Resetear valores
        
        //Volver atrás
        if presentingViewController is UINavigationController{
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
        
        //Volver perfil admin
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
