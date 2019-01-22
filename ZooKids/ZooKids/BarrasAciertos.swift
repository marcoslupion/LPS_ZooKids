//
//  BarrasAciertos.swift
//  ZooKids
//
//  Created by Jefferson on 26/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit

class BarrasAciertos: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    /*var nErrores: Int16 = 0
    var nAciertos: Int16 = 0*/
    
    
    // MARK: atributos
    var botones = [UIButton]()
    let tamanio = CGRect(x: 0, y: 0, width: 35*2, height: 25+5)
    
    // MARK: inicialización
    
    /*override init(frame: CGRect){
     super.init(frame: frame)
     
     
     }*/
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        /*total = BarrasAciertosTabla.nAciertos + BarrasAciertosTabla.nErrores
         cantAciertos = (Double(BarrasAciertosTabla.nAciertos) / Double(total))*10*/
        // if(!cantAciertos.isNaN){
        /*print("Aciertos: ",BarrasAciertosTabla.nAciertos," total: ",total," porcentaje = ", cantAciertos, " de ", BarrasAciertosTabla.nombre)*/
        for i in 0..<5{
            let boton = UIButton(frame: tamanio)
            
            boton.adjustsImageWhenHighlighted = false
            
            boton.tag = i
            botones += [boton]
            addSubview(boton)
        }
        //}
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 60.5, height: 25)
    }
    
    
    //método para mostrar las vistas, por defecto lo hace de forma apilada.
    override func layoutSubviews() {
        for (i, boton) in botones.enumerate() {
            boton.frame.origin.x = CGFloat(i * (60 + 0))
        }
        
}

    /*
    // MARK: atributos
    var botones = [UIButton]()
    let tamanio = CGRect(x: 0, y: 0, width: 96.8, height: 30)
    
    // MARK: inicialización

    /*override init(frame: CGRect){
        super.init(frame: frame)
        
        
    }*/
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        /*let nTotal = Int(nErrores + nAciertos)
         var erroresPorcentaje:Int = (5*Int(nErrores)) / nTotal
         var aciertosPorcentaje:Int = (5*Int(nAciertos)) / nTotal
         
         print("erroresP = ",String(erroresPorcentaje)," aciertosP = ",String(aciertosPorcentaje))
         */
        
        print("nfallos = ",nErrores," ; nAciertos = ",nAciertos)
        for i in 0..<5{
            let boton = UIButton(frame: tamanio)
            
            if( i<2){
                boton.setImage(UIImage(named:"verde"), forState: .Normal)
            }else{
                boton.setImage(UIImage(named:"rosa"), forState: .Normal)
            }
            
            boton.adjustsImageWhenHighlighted = false
            
            boton.tag = i
            botones += [boton]
            addSubview(boton)
        }

        
    }
    
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 96.8, height: 30)
    }
    
    
    //método para mostrar las vistas, por defecto lo hace de forma apilada.
    override func layoutSubviews() {
        for (i, boton) in botones.enumerate() {
            boton.frame.origin.x = CGFloat(i * (96 + 0))
        }
     
    }
    
 
*/

}
