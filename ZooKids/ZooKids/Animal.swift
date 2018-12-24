import UIKit //Eliminamos Foundation

class Animal{
    //MARK: atributos
    var imagen: Int
    var respuesta_dada: String
    var respuesta_verdadera: String
    var respuestas_dadas = [Bool]();
    var resultado : Bool;
    //MARK: Inicialización
    init(){
        self.imagen = 0;
        self.respuesta_dada = "";
        self.respuesta_verdadera = "";
        self.resultado = false;
    }
    
    
}
