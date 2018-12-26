//
//  Inicio_de_sesionViewController.swift
//  ZooKids
//
//  Created by Jefferson on 6/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData



class Inicio_de_sesionViewController: UIViewController {
    
    @IBOutlet weak var userTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.crear_profesor_por_defecto()
        //self.crear_alumno()
    }
    
    func crear_profesor_por_defecto(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Profesor", inManagedObjectContext: managedContext)
        
        let profesor = Profesor(entity:entity!, insertIntoManagedObjectContext: managedContext)
        profesor.nombre_usuario = "admin"
        profesor.contrasenia = "admin"
        
        do{
            try managedContext.save()
            
        }
        catch{
            
            print("error")
        }
    }
    
    func crear_alumno(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Alumno", inManagedObjectContext: managedContext)
        
        let alumno = Alumno(entity:entity!, insertIntoManagedObjectContext: managedContext)
        alumno.nombre_usuario = "alumno"
        alumno.contrasenia = "alumno"
        alumno.foto = ""
        alumno.sexo = "M"
        alumno.fecha_nacimiento = NSDate()
        
        do{
            try managedContext.save()
            
        }
        catch{
            
            print("error")
        }
    }
    
    @IBAction func btnEntrar(sender: UIButton) {
        
        if(userTxtField.text == "" || userTxtField.text == nil || passTxtField.text == "" || passTxtField.text == nil){
            print("texto vacío")
            
            //AlertController campos vacíos
            let alertController = UIAlertController(title: "¡Cuidado!", message: "Usuario y/o contraseña vacío", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return;
        }
        //Configurar contexto
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //Comprobar si es profesor o usuario
        
        //Profesor
        let fetchRequestProfesor = NSFetchRequest(entityName: "Profesor")
        
        
        do{
            let resultsProfesor = try managedContext.executeFetchRequest(fetchRequestProfesor)
            for profesor in resultsProfesor{
                if(profesor.nombre_usuario == userTxtField.text && profesor.contrasenia == passTxtField.text){
                    print("Usuario y contraseña correcto: PROFESOR")
                    let storyboard = UIStoryboard(name: "Admin", bundle: nil)
                    let controller = storyboard.instantiateViewControllerWithIdentifier("admin") as UIViewController
                    
                    self.presentViewController(controller, animated: true, completion: nil)
                }
            }
            
        }
        catch{
            print("error")
        }
        
        //Comprobar si es profesor o usuario
        
        //Usuario
        let fetchRequestAlumno = NSFetchRequest(entityName: "Alumno")
        
        do{
            let resultsAlumno = try managedContext.executeFetchRequest(fetchRequestAlumno)
            for alumno in resultsAlumno{
                if(alumno.nombre_usuario == userTxtField.text && alumno.contrasenia == passTxtField.text){
                    print("Usuario y contraseña correcto: ALUMNO")
                    let storyboard = UIStoryboard(name: "Juego", bundle: nil)
                    let controller = storyboard.instantiateViewControllerWithIdentifier("juego") as UIViewController
                    
                    self.presentViewController(controller, animated: true, completion: nil)
                }
            }
        }
        catch{
            print("error")
        }
        
        //AlertController error comprobar usuario
        let alertController = UIAlertController(title: "¡Cuidado!", message: "Usuario y/o contraseña incorrecto", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func ir_a_juego(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Juego", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("entrada") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func btnPerfil(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let storyboard = UIStoryboard(name: "nino", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("perfilNinio") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
        
        
    }
}
