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
        //self.crear_fallos()
        //self.prueba()
    }
    
    func crear_profesor_por_defecto(){
        //Ya se crea el profesor al crear el alumno
        /*let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
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
        }*/
    }
    
    func crear_alumno(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Alumno", inManagedObjectContext: managedContext)
        
        let alumno = Alumno(entity:entity!, insertIntoManagedObjectContext: managedContext)
        alumno.nombre_usuario = "alumno"
        alumno.contrasenia = "alumno"
        alumno.foto = UIImage(named: "ninio")
        alumno.sexo = "M"
        alumno.fecha_nacimiento = NSDate()
        
        //Asignar el primer profesor
        //Crear uno cualquiera
        let entityProfe = NSEntityDescription.entityForName("Profesor", inManagedObjectContext: managedContext)
        
        let profe = Profesor(entity:entityProfe!, insertIntoManagedObjectContext: managedContext)
        //profe.alumnos.append(alumno)
        profe.nombre_usuario="admin"
        profe.contrasenia="admin"
        profe.email = "admin@email.es"
        
        alumno.profesor=profe

        do{
            try managedContext.save()
            
        }
        catch{
            
            print("error")
        }
    }
    
    func crear_fallos(){
        //Para evitar que al acceder a los fallos haya valores nulos se inicializan los fallos a 0
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Fallo", inManagedObjectContext: managedContext)
        
        
        
        var opciones_totales = [String]();
        opciones_totales.append("Mamífero");
        opciones_totales.append("Pez");
        opciones_totales.append("Anfibio");
        opciones_totales.append("Reptil");
        opciones_totales.append("Invertebrado");
        opciones_totales.append("Insecto");
        opciones_totales.append("Ave");
        
        for str in opciones_totales{
            let fallos = Fallo(entity:entity!, insertIntoManagedObjectContext: managedContext)
            fallos.fallos = 0 as Int16!
            fallos.tipo_animal = str
            
            do{
                try managedContext.save()
                
            }
            catch{
                
                print("error")
            }
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
                    let controller = storyboard.instantiateViewControllerWithIdentifier("viewAdmin") as UIViewController
                    
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
                    PerfilNinioViewController.ninioIniciado = alumno as! Alumno
                    let storyboard = UIStoryboard(name: "nino", bundle: nil)
                    let controller = storyboard.instantiateViewControllerWithIdentifier("perfilNinio") as UIViewController
                    
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
    
    /*@IBAction func ir_a_juego(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Juego", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("entrada") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }*/
    
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
    
    /*@IBAction func btnPerfil(sender: AnyObject) {
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //let managedContext = appDelegate.managedObjectContext
        let storyboard = UIStoryboard(name: "nino", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("perfilNinio") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
        
 
    }*/
    
    func prueba(){
        //Mostrar todos los objetos del Core Data
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //Profesor
        
        let fetchRequestProfesor = NSFetchRequest(entityName: "Profesor")
        
        do{
            let resultsProfesor = try managedContext.executeFetchRequest(fetchRequestProfesor)
            for profesor in resultsProfesor as! [Profesor]{
                print("Profesor: Nombre = ",profesor.nombre_usuario," ; contraseña = ",profesor.contrasenia," ; email = ",profesor.email," número alumnos = ",profesor.alumnos.count)
                for elements in profesor.alumnos{
                    print("nombre alumno = ",elements.nombre_usuario)
                }
            }
            
        }
        catch{
            print("error")
        }

        
        //Alumno
        
        let fetchRequestAlumno = NSFetchRequest(entityName: "Alumno")
        
        do{
            let resultsAlumno = try managedContext.executeFetchRequest(fetchRequestAlumno)
            for alumno in resultsAlumno as! [Alumno]{
                print("Alumno: Nombre = ",alumno.nombre_usuario," ; contraseña = ",alumno.contrasenia,
                      " ; sexo = ",alumno.sexo, " ; profesor asignado = ",alumno.profesor.nombre_usuario,
                      " ; fecha = ",alumno.fecha_nacimiento.description," ; nº partidas = ",alumno.partidas.count)
                for part in alumno.partidas{
                    print("Partida = ",part.id_partida," del alumno ", part.alumno.nombre_usuario)
                }
            }
            
        }
        catch{
            print("error")
        }
        
        //Partida
        let fetchRequestPartidas = NSFetchRequest(entityName: "Partida")
        do{
            let resultsPartidas = try managedContext.executeFetchRequest(fetchRequestPartidas)
            for partida in resultsPartidas as! [Partida]{
                print("Partida: id = ",partida.id_partida," aciertos = ",partida.num_aciertos," fallos = ",partida.num_fallos, "; pertenece al alumno = ",partida.alumno.nombre_usuario)
            }
            
        }catch{
            print("Error")
        }

        //Fallo
        
        let fetchRequestFallos = NSFetchRequest(entityName: "Fallo")
        do{
            let resultsFallos = try managedContext.executeFetchRequest(fetchRequestFallos)
            for fallo in resultsFallos{
                print("Fallo: fallos = ",fallo.fallos," tipo de animal = ",fallo.tipo_animal)
            }
        }catch{
            print("Error")
        }
        
    }
}
