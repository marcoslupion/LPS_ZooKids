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
                self.guardarFallo(animal.respuesta_verdadera)

            }
            
            //Fallos en la respuesta final
            /*
            if(animal.resultado == false){
                //Se almacena el animal que ha fallado
                self.guardarFallo(animal.respuesta_verdadera)
                
            }
 */
        }
        
        //Guardar partida
        
        //Primero crear alumno mock
        /*let entity2 = NSEntityDescription.entityForName("Alumno", inManagedObjectContext: managedContext)
        let alumno = Alumno(entity:entity2!, insertIntoManagedObjectContext: managedContext)
        alumno.contrasenia = "prueba"
        alumno.fecha_nacimiento = NSDate()
        alumno.foto = UIImage(named: "ninio")
        alumno.sexo="M"
        alumno.nombre_usuario="prueba"
        
        do{
            try managedContext.save()
            
        }
        catch{
            
            print("error")
        }*/
        
        var alumno: Alumno!
        let nombreAlumno = "prueba"
        let fetchRequestAlumno = NSFetchRequest(entityName: "Alumno")
        fetchRequestAlumno.predicate = NSPredicate(format: "nombre_usuario == %@",nombreAlumno)
        do{
            let resultsAlumnoEncontrado = try managedContext.executeFetchRequest(fetchRequestAlumno)
            
            if (resultsAlumnoEncontrado.count != 0){
                    alumno = resultsAlumnoEncontrado[0] as! Alumno
            }
            
            try managedContext.save()
            
        }catch{
            print("Error")
        }


        //Segundo guardar partida y asociar alumno
        let partida = Partida(entity:entity!, insertIntoManagedObjectContext: managedContext)
        
        partida.fecha = NSDate()
        partida.id_partida = idPartida
        partida.num_aciertos = numAciertos
        partida.num_fallos = numFallos
        partida.alumno = alumno
        
        //partida.setValue(alumno, forKey: "alumno")
        
        do{
            try managedContext.save()
            
        }
        catch{
            
            print("error")
        }
        
        
        //TODO :
        
        //partida.setValue(ALUMNO, forKey: "alumno")
        
        //Mock : cargar el alumno creado por defecto para añadirlo al CoreData
        /*let fetchRequestAlumno = NSFetchRequest(entityName: "Alumno")
        fetchRequestAlumno.predicate = NSPredicate(format: "nombre_usuario == %@","alumno")
        do{
            let resultsAlumnoEncontrado = try managedContext.executeFetchRequest(fetchRequestAlumno)
            
            if (resultsAlumnoEncontrado.count != 0){
                let alumnoEncontrado = resultsAlumnoEncontrado[0] as! Alumno
                partida.setValue(alumnoEncontrado, forKey: "alumno")
                
            }
            
            try managedContext.save()
            
        }catch{
            print("Error")
            
        }*/
        

        
    }
    
    func resetear_variables_globales(){
        animales.removeAll();
        numeros.removeAll();
        estadoAnimal = (-1);
        
    }
    
    func guardarFallo(respuestaCorrecta:String){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext

        
        //Almacenar fallo en Core Data
        //var numFallosAnimal = 0
        //var tipoAnimalFallo = ""
        
        //Cargar el tipo de animal para añadir los valores
        let fetchRequestFalloAnimal = NSFetchRequest(entityName: "Fallo")
        fetchRequestFalloAnimal.predicate = NSPredicate(format: "tipo_animal == %@",respuestaCorrecta)
        do{
            let resultsFalloAnimal = try managedContext.executeFetchRequest(fetchRequestFalloAnimal)
            
            if (resultsFalloAnimal.count != 0){
                let resultado = resultsFalloAnimal[0]
                var fallosAnteriores = resultado.valueForKey("fallos") as? Int
                if (fallosAnteriores == nil ){
                    fallosAnteriores = 1
                }else{
                    fallosAnteriores=fallosAnteriores!+1
                }
                resultado.setValue(fallosAnteriores, forKey: "fallos")
                
            }
            
            try managedContext.save()
            
        }catch{
            print("Error")
        }
        
    }
}
