//
//  ViewController.swift
//  Malsha_C0871063_GuessPrime
//
//  Created by Malsha Lambton on 2022-10-22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var answerImage: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet var nonPrimeTap: UITapGestureRecognizer!
    @IBOutlet var primeTap: UITapGestureRecognizer!
    var timer = Timer()
    var seconds = 0
    var wrongAnswerCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()

    }
    
    private func startGame(){
        seconds = 0
        timer.invalidate()
        nonPrimeTap.isEnabled = true
        primeTap.isEnabled = true
        answerImage.image = nil
        let randomInt = Int.random(in: 0..<1000)
        numberLabel.text = String(randomInt)
        startTimer()
    }
    private func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction(){
        if(seconds == 3) {
            if wrongAnswerCount == 5 {
                numberLabel.text = ""
                wrongAnswerCount = 0
                answerImage.image = nil
                timer.invalidate()
                let alert = UIAlertController(title: "Error", message: "Game Over!!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                    
                    self.numberLabel.text = "Game Over"
                })
                let resetAction = UIAlertAction(title: "Reset", style: .default, handler: { _ in
                    self.startGame()
                    
                })
                alert.addAction(okAction)
                alert.addAction(resetAction)
                self.present(alert, animated: true)
            }else{
                startGame()
            }
        }else{
            seconds += 1
        }
    }
    
    @IBAction func didTapPrimeImageView(_ sender: UITapGestureRecognizer) {
        nonPrimeTap.isEnabled = false
        primeTap.isEnabled = false
        
        let selectedNumber = Int(numberLabel.text ?? "") ?? 0
        let isPrime = checkPrimeNumber(number: selectedNumber)
        
        if isPrime {
            answerImage.image = UIImage(named: "CorrectIcon")
        }else{
            answerImage.image = UIImage(named: "WrongIcon")
            wrongAnswerCount += 1
        }
    }

    @IBAction func didTapNonPrimeImageView(_ sender: UITapGestureRecognizer) {
        nonPrimeTap.isEnabled = false
        primeTap.isEnabled = false
        let selectedNumber = Int(numberLabel.text ?? "") ?? 0
        let isPrime = checkPrimeNumber(number: selectedNumber)
        
        if isPrime {
            answerImage.image = UIImage(named: "WrongIcon")
            wrongAnswerCount += 1
        }else{
            answerImage.image = UIImage(named: "CorrectIcon")
            
        }
    }
    
    private func checkPrimeNumber(number : Int) -> Bool {
        
        if(number == 1 || number == 0){
            return false
        }

        var i = 2
        while i*i <= number{
            if (number % i == 0){
                return false
            }
            i = i + 1
        }
        return true
    }
}

