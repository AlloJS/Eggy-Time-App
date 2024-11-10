import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var minutList : [String:Int] = ["Coque": 300,"Medio": 420,"Sodo": 600]
    var audioPlayer: AVAudioPlayer?
    @IBOutlet weak var countDown: UILabel!
    @IBOutlet weak var cockButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var sodoButton: UIButton!
    var timer = Timer()
    var counter = 0
    var secondPassed = 60
    @IBOutlet weak var progressBar: UIProgressView!
    var valRange : Float = 0.0
    @IBOutlet weak var stopButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        timer.invalidate()
        counter = 0
        let nameButton : String! = sender.titleLabel!.text
    
        secondPassed = minutList[nameButton]!
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
    }
    
    func setupUI(){
        styleBtn(btn: cockButton)
        styleBtn(btn: mediumButton)
        styleBtn(btn: sodoButton)
        styleBtn(btn: stopButton)
        
        progressBar.progress = valRange
        countDown.text = "0"
        progressBar.layer.cornerRadius = 10 // Arrotonda i bordi
        progressBar.clipsToBounds = true
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 3) // Scala l'altezza
    }
    
    func styleBtn(btn: UIButton) {
        btn.layer.cornerRadius = 10
        btn.layer.shadowColor = UIColor.black.cgColor  // Colore dell'ombra
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)  // Posizione dell'ombra
        btn.layer.shadowOpacity = 0.5  // Opacità dell'ombra (0.0 a 1.0)
        btn.layer.shadowRadius = 4  // Raggio di sfocatura dell'ombra
    }

    
    @objc func timerAction() {
        if counter < secondPassed {
            valRange = Float(counter) / Float(secondPassed)
            //countDown.text = "\(secondPassed - counter)"
            countDown.text = formatTime(seconds: secondPassed - counter)
            counter += 1
            progressBar.progress = valRange
        } else {
            timer.invalidate()
            counter = 0
            progressBar.progress = 1
            countDown.text = "Eggy is ready"
            playSound()
        }
    }
    
    @IBAction func timerStop(_ sender: UIButton) {
        timer.invalidate()
        counter = 0
        progressBar.progress = 0.0
        countDown.text = "Stop"
    }
    
    func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
    
    func playSound() {
            guard let url = Bundle.main.url(forResource: "ring", withExtension: "mp3") else {
                print("File audio non trovato")
                return
            }
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Errore durante la riproduzione del suono: \(error)")
            }
        }
    
}

