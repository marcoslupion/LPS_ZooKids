//
//  TestViewController.swift
//  ZooKids
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit

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
        calcular_correcta_nuevo();
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func escoge_opcion_1(sender: UIButton) {
        /*
         if respuesta_seleccionada{
         return;
         }
         respuesta_dada = (sender.titleLabel?.text)!;
         respuesta_seleccionada = true;
         procesar_resultado(0);
         */
        
    }
    
    
    @IBAction func escoge_opcion_2(sender: UIButton) {
        /*
         if respuesta_seleccionada{
         return;
         }
         respuesta_dada = (sender.titleLabel?.text)!;
         respuesta_seleccionada = true;
         procesar_resultado(1);
         */
        
    }
    @IBAction func escoge_opcion_3(sender: UIButton) {
        /*
         if respuesta_seleccionada{
         return;
         }
         respuesta_dada = (sender.titleLabel?.text)!;
         respuesta_seleccionada = true;
         procesar_resultado(2);
         */
        
    }
    func calcular_correcta(){
        //este es el método que calcula cuál es la respuesta correcta de entre todas.
        //respuesta_correctya = lo que salga del metodo
        self.respuesta_correcta = algoritmo();
        opciones_mostradas.append(self.respuesta_correcta);
        
        //generar_2_opciones();
        //insertar_botones();
        
    }
    
    func calcular_correcta_nuevo(){
        
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
        
        let limite = 3 - opciones_mostradas.count
        
        var contador = 0
        while contador<limite {
            let numAleatorio=Int(arc4random_uniform(6))
            print("Entra en el bucle")
            if opciones_totales[numAleatorio] != respuesta_correcta && opciones_totales[numAleatorio] != correcta_establecida  && !opciones_mostradas.contains(opciones_totales[numAleatorio]) {
                opciones_mostradas.append(opciones_totales[numAleatorio]);
                print("Opcion escogida : ");
                print(opciones_totales[numAleatorio]);
                print(numAleatorio)
                contador=contador+1;
            }
        }
        
    }
    func insertar_botones_app2(){
        if opciones_mostradas.count == 1{
            //solo mostrar un boton y además con los iconos del robot y del niño
            opcion_2.backgroundColor = UIColor.greenColor()
            opcion_2.setTitle(opciones_mostradas[0], forState: UIControlState.Normal);
            opcion_1.hidden = true;
            opcion_3.hidden = true
        }else{
            //en el boton 1 se pone lo que es y en el de abajo lo que se deduce
            opcion_3.hidden = true;
            opcion_1.setTitle(opciones_mostradas[0], forState: UIControlState.Normal);
            opcion_2.setTitle(opciones_mostradas[1], forState: UIControlState.Normal);
            opcion_1.backgroundColor = UIColor.redColor()
            opcion_2.backgroundColor = UIColor.yellowColor()
        }
        /*
         
         print(opciones_mostradas);
         
         var contador = 0 ;
         var numeros_escogidos = [Int]();
         while contador<3 {
         let numAleatorio=Int(arc4random_uniform(3));
         print("Se muestran los numeros");
         if !numeros_escogidos.contains(numAleatorio){
         numeros_escogidos.append(numAleatorio);
         print(numAleatorio);
         contador = contador + 1;
         }
         
         }
         print(opciones_mostradas[numeros_escogidos[0]]);
         print(opciones_mostradas[numeros_escogidos[1]]);
         print(opciones_mostradas[numeros_escogidos[2]]);
         let numeros = [0,1,2]
         
         for a in numeros {
         let opcion = opciones_mostradas[numeros_escogidos[a]]
         print("ESTO ES DENTRO DEL BUCLE DE LOS COJONES")
         print(a)
         print(respuesta_correcta)
         print(correcta_establecida)
         print(opcion)
         if a==0 {
         opcion_1.setTitle(opciones_mostradas[numeros_escogidos[a]], forState: UIControlState.Normal);
         if respuesta_correcta == self.correcta_establecida && respuesta_correcta == opcion {
         opcion_1.backgroundColor = UIColor.greenColor()
         print("Entra porque son iguales 0 ")
         }else if(opcion == self.correcta_establecida && opcion != self.respuesta_correcta ){
         //mostrar el item del robotn
         opcion_1.backgroundColor = UIColor.redColor()
         }else if(opcion == self.respuesta_correcta && opcion != self.correcta_establecida ){
         //mostrar el item del niño
         opcion_1.backgroundColor = UIColor.yellowColor()
         }else{
         //no mostrar ninguna
         //opcion_1.backgroundColor = UIColor.blueColor()
         }
         
         }else if a==1{
         opcion_2.setTitle(opciones_mostradas[numeros_escogidos[a]], forState: UIControlState.Normal);
         if respuesta_correcta == self.correcta_establecida && respuesta_correcta == opcion {
         opcion_2.backgroundColor = UIColor.greenColor()
         print("Entra porque son iguales 1 ")
         }else if(opcion == self.correcta_establecida && opcion != self.respuesta_correcta ){
         //mostrar el item del robotn
         opcion_2.backgroundColor = UIColor.redColor()
         }else if(opcion == self.respuesta_correcta && opcion != self.correcta_establecida ){
         //mostrar el item del niño
         opcion_2.backgroundColor = UIColor.yellowColor()
         }else{
         //no mostrar ninguna
         //opcion_2.backgroundColor = UIColor.blueColor()
         }
         }else{
         opcion_3.setTitle(opciones_mostradas[numeros_escogidos[a]], forState: UIControlState.Normal);
         if respuesta_correcta == self.correcta_establecida && respuesta_correcta == opcion {
         opcion_3.backgroundColor = UIColor.greenColor()
         print("Entra porque son iguales 2 ")
         }else if(opcion == self.correcta_establecida && opcion != self.respuesta_correcta ){
         //mostrar el item del robotn
         opcion_3.backgroundColor = UIColor.redColor()
         }else if(opcion == self.respuesta_correcta && opcion != self.correcta_establecida ){
         //mostrar el item del niño
         opcion_3.backgroundColor = UIColor.yellowColor()
         }else{
         //no mostrar ninguna
         //opcion_3.backgroundColor = UIColor.blueColor()
         }
         }
         }
         */
        
        estadoAnimal = estadoAnimal + 1 ;
        
        /*
         opcion_1.setTitle(opciones_mostradas[numeros_escogidos[0]], forState: UIControlState.Normal);
         opcion_2.setTitle(opciones_mostradas[numeros_escogidos[1]], forState: UIControlState.Normal);
         opcion_3.setTitle(opciones_mostradas[numeros_escogidos[2]], forState: UIControlState.Normal);
         */
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
        
        //se ha comentado porque todavia el array de respuestas no es de tipo string. No se habia
        //tenido en cuenta que había que introducir el número de patas del animal
        
    }
    
    
    @IBAction func siguiente_animal(sender: UIButton) {
        
        
        if estadoAnimal == 5{
            print(animales);
            print("ESTE ES EL ULTIMO ANIMAL, POR LO QUE SE NAVEGA");
            //ya se han hecho 5 animales, se navega a la ventana de resultados;
            /*
             if presentingViewController is UINavigationController{
             dismissViewControllerAnimated(true, completion: nil)
             } else {
             navigationController!.popViewControllerAnimated(true)
             }*/
            
            let storyboard = UIStoryboard(name: "Juego", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("resultadosN") as UIViewController
            
            self.presentViewController(controller, animated: true, completion: nil)
        }else{
            /*
             if presentingViewController is UINavigationController{
             dismissViewControllerAnimated(true, completion: nil)
             } else {
             navigationController!.popViewControllerAnimated(true)
             }
             */
            
            let storyboard = UIStoryboard(name: "Juego", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("entrada") as UIViewController
            
            self.presentViewController(controller, animated: true, completion: nil)
            
        }
        
        
    }
    
    
    func procesar_resultado(boton : Int){
        
        
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
