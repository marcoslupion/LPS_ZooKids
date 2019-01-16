//
//  Inicio_de_sesionViewController.swift
//  ZooKids
//
//  Created by Jefferson on 6/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData


var administrador = false;
var app = 1;
var animales_tipo = Dictionary<Int,[String]>()

class Inicio_de_sesionViewController: UIViewController {
    
    @IBOutlet weak var userTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.rellenar_animales()
        
        let esta = self.comprobar_predeterminado()
        if !esta{
            print("Se crea el alumno predeterminado y los fallos")
            self.crear_alumno()
            //self.crear_fallos()
            
        }
        
        //self.prueba() //Muestra el CoreData
    }
    
    /*func crear_profesor_por_defecto(){
     //Ya se crea el profesor al crear el alumno
     let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
     
     let managedContext = appDelegate.managedObjectContext
     
     let entity = NSEntityDescription.entityForName("Profesor", inManagedObjectContext: managedContext)
     
     let profesor = Profesor(entity:entity!, insertIntoManagedObjectContext: managedContext)
     profesor.nombre_usuario = "admin"
     profesor.contrasenia = "admin"
     profesor.email = "profe@gmail.com"
     
     do{
     try managedContext.save()
     
     }
     catch{
     
     print("error")
     }
     }*/
    
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
    
    func rellenar_animales(){
        if animales_tipo.isEmpty{
            animales_tipo[0] = ["oso","Mamífero"]
            animales_tipo[1] = ["rana","Anfibio"]
            animales_tipo[2] = ["tucán","Ave"]
            animales_tipo[3] = ["cebra","Mamífero"]
            animales_tipo[4] = ["tiburón","Pez"]
            animales_tipo[5] = ["león","Mamífero"]
            animales_tipo[6] = ["jirafa","Mamífero"]
            animales_tipo[7] = ["koala","Mamífero"]
            animales_tipo[8] = ["avispa","Insecto"]
            animales_tipo[9] = ["araña","Insecto"]
            animales_tipo[10] = ["pinguino","Ave"]
            animales_tipo[11] = ["zorro","Mamífero"]
            animales_tipo[12] = ["cuervo","Ave"]
            animales_tipo[13] = ["caballo","Mamífero"]
            animales_tipo[14] = ["elefante","Mamífero"]
            animales_tipo[15] = ["tortuga","Anfibio"]
            animales_tipo[16] = ["delfin","Mamífero"]
            animales_tipo[17] = ["medusa","Invertebrado"]
            animales_tipo[18] = ["caracol","Invertebrado"]
            animales_tipo[19] = ["buho","Ave"]
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
            for pr in resultsProfesor{
                if(pr.nombre_usuario == userTxtField.text && pr.contrasenia == passTxtField.text){
                    //print("Usuario y contraseña correcto: PROFESOR")
                    profesor = pr as! Profesor
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
                    //Variable global profesor es el profesor al que pertenece el alumno
                    //cuando se inicia como alumno
                    let al = alumno as! Alumno
                    profesor = al.profesor
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
    
    func comprobar_predeterminado() -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        var esta = false;
        
        
        //Alumno
        
        let fetchRequestAlumno = NSFetchRequest(entityName: "Alumno")
        
        do{
            let resultsAlumno = try managedContext.executeFetchRequest(fetchRequestAlumno)
            for alumno in resultsAlumno as! [Alumno]{
                if alumno.nombre_usuario == "alumno" {
                    esta = true;
                    print("SE HA ENCONTRADO UN USUARio")
                }
            }
            
        }
        catch{
            print("error")
        }
        
        
        return esta;
        
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
            for fallo in resultsFallos as! [Fallo]{
                print("Fallo: Profesor = ",fallo.admin.nombre_usuario," animal = ",fallo.tipo_animal," nº fallos = ",fallo.fallos)
            }
        }catch{
            print("Error")
        }
        
        //ModeloDatos (resultados de las partidas)
        let fetchRequestModeloDatos = NSFetchRequest(entityName: "ModeloDatos")
        do{
            let resultsModeloDatos = try managedContext.executeFetchRequest(fetchRequestModeloDatos)
            for modeloDatos in resultsModeloDatos as! [ModeloDatos]{
                print("Modelo de datos: Animal = ",modeloDatos.animal," resultado = ",modeloDatos.resultado)
                print("Valores:")
                print("Acuático = ",modeloDatos.acuaticio.description)
                print("Alas = ",modeloDatos.alas.description)
                print("Aletas = ",modeloDatos.aletas.description)
                print("Dientes = ",modeloDatos.dientes.description)
                print("Esqueleto = ",modeloDatos.esqueleto.description)
                print("Leche = ",modeloDatos.leche.description)
                print("Pulmones = ",modeloDatos.pulmones.description)
                print("Piernas = ",modeloDatos.piernas.description)
                
            }
            
        }catch{
            print("Error")
        }

        
    }
}
