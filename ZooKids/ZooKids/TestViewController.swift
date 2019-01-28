//
//  TestViewController.swift
//  ZooKids
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData

class TestViewController: ViewController {
    var respuesta_dada = "";
    var opciones_mostradas = [String]();
    var opciones_totales = [String]();
    var respuesta_correcta = "";
    var respuesta_seleccionada = false;
    var correcta_establecida =  "";
    @IBOutlet weak var opcion_3: UIButton!
    @IBOutlet weak var opcion_2: UIButton!
    @IBOutlet weak var opcion_1: UIButton!
    var seleccionada_alumno_1 = ""
    var anterior  = UIButton()
    var primera_vez_click = true;
    
    @IBOutlet weak var salir_app1: UIButton!
    @IBOutlet weak var btn_mamifero: UIButton!
    
    @IBOutlet weak var siguiente_animal: UIButton!
    @IBOutlet weak var btn_ave: UIButton!
    
    @IBOutlet weak var btn_insecto: UIButton!
    
    @IBOutlet weak var btn_anfibio: UIButton!
    
    @IBOutlet weak var btn_pez: UIButton!
    
    @IBOutlet weak var btn_reptil: UIButton!
    
    @IBOutlet weak var btn_invertebrado: UIButton!
    
    @IBOutlet weak var img_o1: UIImageView!
    
    @IBOutlet weak var img_o2: UIImageView!
    
    @IBOutlet weak var img_o3: UIImageView!
    
    @IBOutlet weak var sw1: UIStackView!
    @IBOutlet weak var sw2: UIStackView!
    @IBAction func salir_app1(sender: UIButton) {
        if seleccionada_alumno_1 != ""{
            procesar_resultados_app1()
            resetear_variables_globales();
            let storyboard = UIStoryboard(name: "nino", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("perfilNinio") as UIViewController
            
            self.presentViewController(controller, animated: true, completion: nil)
        
        }
        
        
        
    }
    @IBOutlet weak var sw3: UIStackView!
    @IBAction func seleccionar_tipo_animal_boton(sender: UIButton) {
        seleccionada_alumno_1 = sender.titleLabel!.text!
         // sender.backgroundColor = UIColor.yellowColor()
        if !primera_vez_click{
            anterior.backgroundColor = UIColor(red:0.0, green:122.0/255.0, blue:1.0, alpha:1.0)
        }
        if (seleccionada_alumno_1 == "Mamifero"){
            anterior = btn_mamifero
            anterior.backgroundColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        }else if (seleccionada_alumno_1 == "Ave"){
            anterior = btn_ave
            anterior.backgroundColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        }else if (seleccionada_alumno_1 == "Insecto"){
            anterior = btn_insecto
            anterior.backgroundColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        }
        else if (seleccionada_alumno_1 == "Anfibio"){
            anterior = btn_anfibio
            anterior.backgroundColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        }
        else if (seleccionada_alumno_1 == "Pez"){
            anterior = btn_pez
            anterior.backgroundColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        }
        else if (seleccionada_alumno_1 == "Reptil"){
            anterior = btn_reptil
            anterior.backgroundColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        }else{
            anterior = btn_invertebrado
            anterior.backgroundColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        }
        primera_vez_click = false;
       
    }
   
    func resetear_variables_globales(){
        animales.removeAll();
        numeros.removeAll();
        estadoAnimal = (-1);
        
    }
    @IBAction func salir_juego(sender: UIBarButtonItem) {
        resetear_variables_globales()
        let storyboard = UIStoryboard(name: "nino", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("perfilNinio") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        navigationController?.navigationBar.barTintColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        super.viewDidLoad()
        if app == 1{
            mostrar_botones()
        }else{
            calcular_correcta_nuevo();
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func escoge_opcion_1(sender: UIButton) {
        img_o1.image = UIImage(named: "RespuestaNinio")
    }
    
    
    @IBAction func escoge_opcion_2(sender: UIButton) {
        img_o2.image = UIImage(named: "RespuestaNinio")
        
    }
    @IBAction func escoge_opcion_3(sender: UIButton) {
        img_o3.image = UIImage(named: "RespuestaNinio")
    }
    func mostrar_botones(){
        //boton_de_finalizar.hidden = false;
        
        
        self.opcion_3.frame.size = CGSize(width: 20.0, height: 2.0)
        self.opcion_2.frame.size = CGSize(width: 20.0, height: 2.0)
        self.opcion_1.frame.size = CGSize(width: 20.0, height: 2.0)
        
        sw1.hidden = true;
        sw2.hidden = true;
        sw3.hidden = true;
        

        
        if estadoAnimal == 2{
            //para probar se puede poner cuando estadoAnimal = 1            
            //mostrar el boton de acabar
            
            //ocultar el boton de siguiente animal
            siguiente_animal.hidden = true;
        }
    }
    func procesar_resultados_app1(){
        print("PROCESO DE LOS RESULTADOS OBTENIDOS : ")
        //esta variable contiene el tipo de animal que el niño ha escogido : 
        print(seleccionada_alumno_1)
        
        //esta es la variable donde están las respuestas del alumno
        //animales[estadoAnimal]
        print(animales[estadoAnimal])
        let an = animales[estadoAnimal]
        /*print("Elegido por el alumno: Nombre animal = ",an.nombre," respuesta dada = ",an.respuesta_dada, " respuesta establecida = ",an.respuesta_verdadera_establecida," imagen = ",an.imagen)
        print("Respuestas dadas ",an.respuestas_dadas)*/
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("ModeloDatos", inManagedObjectContext: managedContext)
        
        let modeloDatos = ModeloDatos(entity:entity!, insertIntoManagedObjectContext: managedContext)
        modeloDatos.leche = comprobar_bool(an.respuestas_dadas[0])
        modeloDatos.alas = comprobar_bool(an.respuestas_dadas[1])
        modeloDatos.pulmones = comprobar_bool(an.respuestas_dadas[2])
        modeloDatos.piernas = Int16(an.respuestas_dadas[3])
        modeloDatos.dientes = comprobar_bool(an.respuestas_dadas[4])
        modeloDatos.acuatico = comprobar_bool(an.respuestas_dadas[5])
        modeloDatos.aletas = comprobar_bool(an.respuestas_dadas[6])
        modeloDatos.esqueleto = comprobar_bool(an.respuestas_dadas[7])
        modeloDatos.animal = an.nombre
        modeloDatos.resultado = seleccionada_alumno_1
        
        do{
            try managedContext.save()
        }
        catch{
            
            print("error")
        }
        
        
        
        
    }
    
    func comprobar_bool(i: Int) -> Bool{
        if(i == 0) {
            return false
        }
        
        return true
    }
    func desactivar_botones_app1(){
    //desactivar los botones de la app 1
        btn_invertebrado.hidden = true;
        btn_mamifero.hidden = true
        btn_ave.hidden = true;
        btn_anfibio.hidden = true;
        btn_insecto.hidden = true;
        btn_reptil.hidden = true;
        btn_pez.hidden = true;
        salir_app1.hidden = true
        
    
    }
    func calcular_correcta_nuevo(){
        desactivar_botones_app1()
        
        self.correcta_establecida = animales[estadoAnimal].respuesta_verdadera_establecida
        //este es el método que calcula cuál es la respuesta correcta de entre todas.
        //respuesta_correctya = lo que salga del metodo
        self.respuesta_correcta = algoritmo();
        animales[estadoAnimal].respuesta_verdadera_algoritmo = self.respuesta_correcta        
        
        if self.correcta_establecida == self.respuesta_correcta{
            opciones_mostradas.append(self.respuesta_correcta);
            animales[estadoAnimal].resultado = true;
        }else{
            
            opciones_mostradas.append(self.correcta_establecida);
            opciones_mostradas.append(self.respuesta_correcta);
            animales[estadoAnimal].resultado = false;
        }
        
        //se generan las opciones restantes para poder hacer la muestra
        //generar_opciones();
        insertar_botones_app2();
        
    }
    
    func generar_opciones(){
        opciones_totales.append("Mamífero");
        opciones_totales.append("Pez");
        opciones_totales.append("Anfibio");
        opciones_totales.append("Reptil");
        opciones_totales.append("Invertebrado");
        opciones_totales.append("Insecto");
        opciones_totales.append("Ave");
        
    }
    func insertar_botones_app2(){
        if opciones_mostradas.count == 1{
            //solo mostrar un boton y además con los iconos del robot y del niño
            opcion_2.backgroundColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
            img_o2.image = UIImage(named: "RespuestaCorrecta")
            opcion_2.setTitle(opciones_mostradas[0], forState: UIControlState.Normal);
            opcion_1.hidden = true;
            opcion_3.hidden = true
        }else{
            //en el boton 1 se pone lo que es y en el de abajo lo que se deduce
            opcion_3.hidden = true;
            opcion_1.setTitle(opciones_mostradas[0], forState: UIControlState.Normal);
            opcion_2.setTitle(opciones_mostradas[1], forState: UIControlState.Normal);
            img_o1.image = UIImage(named: "RespuestaApp")
            opcion_1.backgroundColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
            img_o2.image = UIImage(named: "RespuestaNinio")
            opcion_2.backgroundColor = UIColor.redColor()
            
        }
        estadoAnimal = estadoAnimal + 1 ;

    }
    
    func algoritmo() -> String {
        print("Entra en el algoritmo de decidir que tipo de animal es")
        
        print(animales[estadoAnimal].respuestas_dadas)
        
        let leche = animales[estadoAnimal].respuestas_dadas[0];
        let alas = animales[estadoAnimal].respuestas_dadas[1];
        let respira = animales[estadoAnimal].respuestas_dadas[2];
        let patas = animales[estadoAnimal].respuestas_dadas[3];
        let dientes = animales[estadoAnimal].respuestas_dadas[4];
        if leche == 0{
            if alas == 0{
                if dientes == 1{
                    if patas <= 2{
                        return "Reptil"
                    }else{
                        return "Anfibio"
                    }
                }else{
                    if patas <= 2{
                        if patas <= 0{
                            return "Invertebrado"
                        }else{
                            return "Ave"
                        }
                        
                    }else{
                        if respira == 1 {
                            return "Insecto"
                        }else{
                            return "Invertebrado"
                        }
                    }
                }
            }else{
                return "Ave"
            }
        }else{
            return "Mamífero"
        }
      
        
    }
    
    
    @IBAction func siguiente_animal(sender: UIButton) {
        if app == 2{
            if estadoAnimal == 5{
                print(animales);
                print("ESTE ES EL ULTIMO ANIMAL, POR LO QUE SE NAVEGA");
                
                let storyboard = UIStoryboard(name: "Juego", bundle: nil)
                let controller = storyboard.instantiateViewControllerWithIdentifier("resultadosN") as UIViewController
                
                self.presentViewController(controller, animated: true, completion: nil)
            }else{
                
                
                let storyboard = UIStoryboard(name: "Juego", bundle: nil)
                let controller = storyboard.instantiateViewControllerWithIdentifier("entrada") as UIViewController
                
                self.presentViewController(controller, animated: true, completion: nil)
                
            }
        }else{
            
            //se van a tener hasta 20 animales escogidos por lo que el contador va a estar a 20 y cuando llegue a 20, se tiene que ver qué hacer
            if seleccionada_alumno_1 != ""{
                procesar_resultados_app1()
                
                estadoAnimal = estadoAnimal + 1 ;
                let storyboard = UIStoryboard(name: "Juego", bundle: nil)
                let controller = storyboard.instantiateViewControllerWithIdentifier("entrada") as UIViewController
                
                self.presentViewController(controller, animated: true, completion: nil)
                
            }
            
            
        
        }
        
        
        
        
    }
    
    
    /*
     func procesar_resultado(boton : Int){
     animales[estadoAnimal].respuesta_dada = respuesta_dada;
     animales[estadoAnimal].respuesta_verdadera = respuesta_correcta;
     print("SE PROCESA LA RESPUESTA")
     print(respuesta_dada)
     print(respuesta_correcta)
     
     if respuesta_dada == respuesta_correcta {
     print("Se pinta verde, coinciden")
     animales[estadoAnimal].resultado = true;
     if boton == 0{
     opcion_1.backgroundColor = UIColor.greenColor()
     }else if boton == 1{
     opcion_2.backgroundColor = UIColor.greenColor()
     }else{
     opcion_3.backgroundColor = UIColor.greenColor()
     }
     }else{
     print("Se pinta rojo")
     print(boton)
     animales[estadoAnimal].resultado = false;
     if boton == 0{
     opcion_1.backgroundColor = UIColor.redColor()
     //encontrar la correcta
     if opcion_1.titleLabel?.text == respuesta_correcta{
     opcion_1.backgroundColor = UIColor.greenColor()
     
     }else if opcion_2.titleLabel?.text == respuesta_correcta{
     opcion_2.backgroundColor = UIColor.greenColor()
     }else{
     opcion_3.backgroundColor = UIColor.greenColor()
     
     }
     }else if boton == 1{
     opcion_2.backgroundColor = UIColor.redColor()
     //encontrar la correcta
     if opcion_1.titleLabel?.text == respuesta_correcta{
     opcion_1.backgroundColor = UIColor.greenColor()
     
     }else if opcion_2.titleLabel?.text == respuesta_correcta{
     opcion_2.backgroundColor = UIColor.greenColor()
     }else{
     opcion_3.backgroundColor = UIColor.greenColor()
     
     }
     }else{
     print("Se pinta de rojo la opcion 3, no verde")
     opcion_3.backgroundColor = UIColor.redColor()
     //encontrar la correcta
     print("Valores de los botones")
     print(String(opcion_1.titleLabel!.text!))
     print(String(opcion_2.titleLabel!.text!))
     print(String(opcion_3.titleLabel!.text!))
     if String(opcion_1.titleLabel!.text!) == respuesta_correcta{
     opcion_1.backgroundColor = UIColor.greenColor()
     print("Se mete en el boton 1")
     }else if String(opcion_2.titleLabel!.text!) == respuesta_correcta{
     opcion_2.backgroundColor = UIColor.greenColor()
     print("Se mete en el boton 2")
     }else{
     opcion_3.backgroundColor = UIColor.greenColor()
     print("Se mete en el boton 3")
     
     }
     }
     
     
     
     }
     estadoAnimal = estadoAnimal + 1 ;
     print("EL ANIMAL ACTUAL ES EL ANIMAL : ");
     print(estadoAnimal);
     
     
     }
     */
    
    
    
}
