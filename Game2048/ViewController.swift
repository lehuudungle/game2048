//
//  ViewController.swift
//  Game2048
//
//  Created by Admin on 9/28/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var score: UILabel!
    
    var b = Array(count: 4, repeatedValue: Array(count: 4, repeatedValue:0))
    var lose = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        let directions: [UISwipeGestureRecognizerDirection] = [.Right,.Left,.Up,.Down]
        
        for direction in directions{
            let gesture = UISwipeGestureRecognizer(target: self, action: Selector("respondToSwipeGEsture:"))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)

            
        }
        
    }
    func transfer(){
        for(var i = 0; i < 4; i++){
            for(var j = 0; j < 4; j++){
                let numlabel = 100 + (i * 4) + j;
                ConverNumLabel(numlabel, value: String(b[i][j]))
                switch b[i][j] {
                case 2: changeBackColor(numlabel, color: UIColor.greenColor())
                case 4: changeBackColor(numlabel, color: UIColor.yellowColor())
                case 8: changeBackColor(numlabel, color: UIColor.orangeColor())
                case 16: changeBackColor(numlabel, color: UIColor.greenColor())
                case 32: changeBackColor(numlabel, color: UIColor.cyanColor())
                case 64: changeBackColor(numlabel, color: UIColor.redColor())
                case 128: changeBackColor(numlabel, color: UIColor.brownColor())
                    
                default: changeBackColor(numlabel, color: UIColor.darkGrayColor())
                    
                }
                
            }
        }
    }
    func GetScore(value: Int){
        score.text = String(Int(score.text!)! + value)
    }
    func randomNum(type: Int){
        if((!lose)){
            switch type {
            case 0 :
                left()
            case 1 :
                right()
            case 2 :
                up()
            case 3 :
                down()
            default : break
                
            }
        }
        if(checkRandom()){
            var rnlableX = arc4random_uniform(4)
            var rnlableY = arc4random_uniform(4)
            let rdNum = arc4random_uniform(2) == 0 ? 2 : 4
            
            while(b[Int(rnlableX)][Int(rnlableY)] != 0){
                rnlableX = arc4random_uniform(4)
                rnlableY = arc4random_uniform(4)
                
            }
            b[Int(rnlableX)][Int(rnlableY)] = rdNum
            transfer()
            print("chay")
        }
        else if(checkLose()){
            lose = true
            let alert = UIAlertController(title: "Game Over", message: "You Lose", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)


        }

    }
    func checkRandom()-> Bool{
        for(var row = 0; row < 4; row++ ){
            
            for(var col = 0; col < 4; col++ ){
                if(b[row][col] == 0){
                    return true
                }
            }
        }
        return false
    }
    func checkLose()->Bool{
        if(!checkRandom()){
            for( var row = 0; row < 4; row++){
                for(var col = 0; col < 4; col++){
                    
                    if(row - 1 >= 0){
                        if(b[row][col] == b[row-1][col]){
                            return false
                        }
                    }
                    if(row + 1 < 4){
                        if(b[row][col] == b[row+1][col]){
                            return false
                        }
                    }
                    if(col - 1 >= 0){
                        if(b[row][col] == b[row][col-1]){
                            return false
                        }
                    }
                    if(col + 1 < 4){
                        if(b[row][col] == b[row][col+1]){
                            return false
                        }
                    }
                }
            }
            
        }
        
        return true
        
    }
    
    
    func ConverNumLabel(numlabel: Int,let value: String){
        let label = self.view.viewWithTag(numlabel)as! UILabel
        label.text = value
    }
    func changeBackColor(numlabel: Int, color: UIColor){
        let label = self.view.viewWithTag(numlabel)
        label?.backgroundColor = color
        
    }
    
    func respondToSwipeGEsture(gesture: UISwipeGestureRecognizer){

        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch  swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Left:
                randomNum(0)
            case UISwipeGestureRecognizerDirection.Right:
                randomNum(1)
            case UISwipeGestureRecognizerDirection.Up:
                randomNum(2)
            case UISwipeGestureRecognizerDirection.Down:
                randomNum(3)
            default:
                break
            }
        }
    }
    func up(){
        print("len")
        for(var col = 0; col < 4; col++){
            var check = false
            for(var row = 1; row < 4; row++){
                var tx = row  // tx dung de luu vi tri row hien tai
                if(b[row][col] == 0){
                    continue
                }
                for(var rowc = row - 1; rowc != -1; rowc--){
                    if( b[rowc][col] != 0 && b[rowc][col] != b[row][col] || check){
                        break
                    }else{
                        tx = rowc
                    }
                }
                if(tx == row){
                    continue
                }
                if (b[row][col] == b[tx][col]){
                    check = true
                    GetScore(b[tx][col])
                    b[tx][col] *= 2
                }else{
                    b[tx][col] = b[row][col]
                }
                b[row][col] = 0
            }
        }
    }
    func down()
    {
        print("xuong")
        for (var col = 0; col < 4;col++ )
        {
            var check = false
            for (var row = 0; row < 4; row++)
            {
                var tx = row
                
                if (b[row][col] == 0)
                {
                    continue
                }
                for (var rowc = row + 1; rowc < 4; rowc++)
                {
                    if (b[rowc][col] != 0 && (b[rowc][col] != b[row][col] || check))
                    {
                        break;
                    }
                    else
                    {
                        tx = rowc
                    }
                }
                if (tx == row)
                {
                    continue
                }
                if (b[tx][col] == b[row][col])
                {
                    check = true
                    GetScore(b[tx][col])
                    b[tx][col] *= 2
                    
                }
                else
                {
                    b[tx][col] = b[row][col]
                }
                b[row][col] = 0;
            }
        }
    }
    func left()
    {
        print("trai")
        for(var row = 0; row < 4; row++)
        {
            var check = false
            for (var col = 1; col < 4; col++)
            {
                if (b[row][col] == 0)
                {
                    continue
                }
                var ty = col
                for (var colc = col - 1; colc != -1; colc--)
                {
                    if (b[row][colc] != 0 && (b[row][colc] != b[row][col] || check))
                    {
                        break
                    }
                    else
                    {
                        ty = colc
                    }
                }
                if (ty == col)
                {
                    continue;
                }
                if (b[row][ty] == b[row][col])
                {
                    check = true
                    GetScore(b[row][ty])
                    b[row][ty] *= 2
                    
                }
                else
                {
                    b[row][ty]=b[row][col]
                }
                b[row][col] = 0
                
            }
        }
    }
    func right()
    {
        print("phai")
        for(var row = 0; row < 4; row++)
        {
            var check = false
            for (var col = 3; col != -1; col--)
            {
                if (b[row][col] == 0)
                {
                    continue
                }
                var ty = col
                for (var colc = col + 1; colc < 4; colc++)
                {
                    if (b[row][colc] != 0 && (b[row][colc] != b[row][col] || check))
                    {
                        break
                    }
                    else
                    {
                        ty = colc
                    }
                }
                if (ty == col)
                {
                    continue;
                }
                if (b[row][ty] == b[row][col])
                {
                    check = true
                    GetScore(b[row][ty])
                    b[row][ty] *= 2
                    
                }
                else
                {
                    b[row][ty] = b[row][col]
                }
                b[row][col] = 0
                
            }
        }
    }


    
}

