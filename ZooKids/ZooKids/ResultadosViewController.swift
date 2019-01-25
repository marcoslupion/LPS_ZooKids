//
//  ResultadosViewController.swift
//  ZooKids
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData

class ResultadosViewController: ViewController {
    
    @IBOutlet weak var porcentaje: UILabel!
    @IBOutlet weak var mensaje: UILabel!
    override func viewDidLoad() {
        navigationController?.navigationBar.barTintColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        super.viewDidLoad()
        let porcentaje_obtenido = calcular_correctas()
        self.porcentaje.text = String(Int(porcentaje_obtenido)) + " %";
        if porcentaje_obtenido > 50{
            mensaje.text = "¡¡Enhorabuena!!";
        }else{
            mensaje.text = "Hay que estudiar más";
        }
        
        insertar_datos_bd();
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calcular_correctas()-> Double {
        var aciertos = 0.0;
        for animal in animales{
            if animal.resultado == true{
                aciertos = aciertos + 1;
            }
        }
        return (aciertos / 5.0) * 100.0;
    }
    
    @IBAction func ir_perfil(sender: UIButton) {
        resetear_variables_globales();
        let storyboard = UIStoryboard(name: "nino", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("perfilNinio") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func nueva_partida(sender: UIButton) {
        resetear_variables_globales();
        
        let storyboard = UIStoryboard(name: "Juego", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("entrada") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    func insertar_datos_bd(){
        //se tiene que recorrer el array de animales, en el que se tienen todos los datos.
        /*print("UN EJEMPLO DEL PRIMER ANIMAL ES ")
         print(animales[0].respuesta_dada);
         print(animales[0].respuesta_verdadera);
         print(animales[0].imagen);
         print(animales[0].respuestas_dadas);
         print(animales[0].resultado);*/
        
        //se tiene que meter en la base de datos todos los datos que hay recogidos en animales
        
        print("método insertar datos")
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Partida", inManagedObjectContext: managedContext)
        
        //Cargar partidas para coger el id de la última
        
        var idPartida:Int16
        idPartida = -1
        
        
        let fetchRequestPartidas = NSFetchRequest(entityName: "Partida")
        do{
            let resultsPartidas = try managedContext.executeFetchRequest(fetchRequestPartidas)
            for partida in resultsPartidas as! [Partida]{
                if (partida.id_partida > idPartida){
                    idPartida = partida.id_partida
                }
            }
            
            idPartida+=1
            
        }catch{
            print("Error")
        }
        
        //Variables para guardar la partida en Core Data
        var numAciertos = 0 as Int16
        var numFallos = 0 as Int16
        
        for animal in animales{
            //print("Animal = ",animal.respuesta_verdadera, " respuesta dada = ",animal.respuesta_dada)
            //Aciertos y fallos en las preguntas
            
            //ATENCIOOOOOOOOOOOOOOOOOOOOON JOSEF
            //este bucle creo que esta mal, respuestas_dadas contiene lo que se va  contestnado a las preguntas del animal... creo que aqui tienes que hacer el for de arriba comprobando la propiedad de resultado.. de todas formas creo que está hecho en el constructor. Solo habria que comprobar si la respuesta dada es igual que la respuesta verdadera y eso es si ha acertado o no..... seria como he puesto abajo creo
            /*
             for respuestas in animal.respuestas_dadas{
             if (respuestas == true){
             numAciertos+=1
             }else{
             numFallos+=1
             }
             }
             */
            if animal.resultado{
                numAciertos+=1
            }else{
                numFallos+=1
                self.guardarFallo(animal.respuesta_verdadera_establecida)
                
            }
            
            //Fallos en la respuesta final
            /*
             if(animal.resultado == false){
             //Se almacena el animal que ha fallado
             self.guardarFallo(animal.respuesta_verdadera)
             
             }
             */
        }
        
        //Guardar partida y asociar alumno
        let partida = Partida(entity:entity!, insertIntoManagedObjectContext: managedContext)
        
        partida.fecha = NSDate()
        partida.id_partida = idPartida
        partida.num_aciertos = numAciertos
        partida.num_fallos = numFallos
        partida.alumno = PerfilNinioViewController.ninioIniciado
        
        //partida.setValue(alumno, forKey: "alumno")
        
        do{
            try managedContext.save()
            
        }
        catch{
            
            print("error")
        }
        
    }
    
    func resetear_variables_globales(){
        animales.removeAll();
        numeros.removeAll();
        estadoAnimal = (-1);
        
    }
    
    func guardarFallo(respuestaCorrecta:String){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //Guardar fallo para el administrador actual
        let fetchRequestFalloAnimal = NSFetchRequest(entityName: "Fallo")
        //Cargar todos los fallos que pertenecen al admin
        fetchRequestFalloAnimal.predicate = NSPredicate(format: "admin.nombre_usuario == %@", profesor.nombre_usuario)
        do{
            let resultsFalloAnimal = try managedContext.executeFetchRequest(fetchRequestFalloAnimal)
            if(resultsFalloAnimal.count == 0){
                //Inicializar fallos para este admin
                crear_fallos(respuestaCorrecta)
            }else{
                //Añadir fallos a los anteriores
                for fallos in resultsFalloAnimal as! [Fallo]{
                    if(fallos.tipo_animal == respuestaCorrecta){
                        var fallosAnteriores = fallos.valueForKey("fallos") as? Int
                        if (fallosAnteriores == nil ){
                            fallosAnteriores = 1
                        }else{
                            fallosAnteriores=fallosAnteriores!+1
                        }
                        fallos.setValue(fallosAnteriores, forKey: "fallos")
                    }
                    
                }
            }
            
            try managedContext.save()
        }catch{
            print("Error")
            
        }
        
    }
    
    func crear_fallos(respuestaCorrecta:String){
        //Para evitar que al acceder a los fallos haya valores nulos se inicializan los fallos a 0
        
        
        var opciones_totales = [String]();
        opciones_totales.append("Mamífero");
        opciones_totales.append("Pez");
        opciones_totales.append("Anfibio");
        opciones_totales.append("Reptil");
        opciones_totales.append("Invertebrado");
        opciones_totales.append("Insecto");
        opciones_totales.append("Ave");
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Fallo", inManagedObjectContext: managedContext)
        
        for str in opciones_totales{
            
            let fallos = Fallo(entity:entity!, insertIntoManagedObjectContext: managedContext)
            
            fallos.tipo_animal = str
            if(str == respuestaCorrecta){
                fallos.fallos = 1 as Int16!
            }else{
                fallos.fallos = 0 as Int16!
            }
            //fallos.admin = profesor
            fallos.setValue(profesor, forKey: "admin")
            
            
            do{
                try managedContext.save()
                //print("Creado fallo: ",fallos.tipo_animal," nº fallos = ",fallos.fallos," del admin = ",fallos.admin.nombre_usuario)
                
            }
            catch{
                
                print("error")
            }
            
        }
        
    }
    
    
}
