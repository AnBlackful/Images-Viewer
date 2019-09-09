import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var frameButton: UIButton!
    @IBOutlet weak var slideShowButton: UIButton!
    
    let imageArray:Array = ImageManager.shared.makeBase()
    
    var willSlideEnd = 0
    
    var timer: Timer?
    
    var frameX = CGFloat()
    var frameY = CGFloat()
    var frameWidth = CGFloat()
    var frameHeight = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.frameX = self.imagePlace.frame.origin.x
        self.frameY = self.imagePlace.frame.origin.y
        self.frameWidth = self.imagePlace.frame.width
        self.frameHeight = self.imagePlace.frame.height
        self.buttonCustomize()
        self.imagePlace.image = imageArray[0].image
    }
    
    //MARK: - Actions
    
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        self.imagePlace.image = self.imageArray[ImageManager.shared.goPrevious()].image
    }
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        self.imagePlace.image = self.imageArray[ImageManager.shared.goNext()].image
    }
    @IBAction func frameButtonPressed(_ sender: UIButton) {
        self.willSlideEnd+=1
        self.doResizeImage()
    }
    @IBAction func slideShowButtonPressed(_ sender: UIButton) {
        self.willSlideEnd=0
        self.slideShowButton.setTitle("", for: .normal)
        self.doResizeImage()
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(playSlideShow) , userInfo: nil, repeats: true)
    }
    
    //MARK: - Slideshow
    
    @objc func playSlideShow(){
        self.imagePlace.image = self.imageArray[ImageManager.shared.goNext()].image
        if self.willSlideEnd == 1 {
            self.timer?.invalidate()
            self.doResizeImage()
        }
    }
        //MARK: - Resizing Images
    func doResizeImage(){
        if self.imagePlace.frame.origin.x == self.frameX{
            self.doBigImage()
        }else{
            self.doSmallImage()
        }
    }
    
    func doBigImage(){
        self.imagePlace.frame.origin.x = 0
        self.imagePlace.frame.origin.y = 0
        self.imagePlace.frame.size.width = self.view.frame.width
        self.imagePlace.frame.size.height = self.view.frame.height
        self.frameButton.frame.origin.x = 0
        self.frameButton.frame.origin.y = 0
        self.frameButton.frame.size.width = self.view.frame.width
        self.frameButton.frame.size.height = self.view.frame.height
        self.leftButton.titleLabel?.text = ""
        self.rightButton.titleLabel?.text = ""
        self.leftButton.layer.borderWidth = 0
        self.rightButton.layer.borderWidth = 0
    }
    func doSmallImage(){
        self.imagePlace.frame.origin.x = self.frameX
        self.imagePlace.frame.origin.y = self.frameY
        self.imagePlace.frame.size.width = self.frameWidth
        self.imagePlace.frame.size.height = self.frameHeight
        self.frameButton.frame.origin.x = self.frameX
        self.frameButton.frame.origin.y = self.frameY
        self.frameButton.frame.size.width = self.frameWidth
        self.frameButton.frame.size.height = self.frameHeight
        self.leftButton.titleLabel?.text = "<--"
        self.rightButton.titleLabel?.text = "-->"
        self.slideShowButton.titleLabel?.text = "SlideShow"
        self.buttonCustomize()
    }
    
    func buttonCustomize(){
        rightButton.layer.borderWidth = 1
        rightButton.layer.cornerRadius = 17
        leftButton.layer.borderWidth = 1
        leftButton.layer.cornerRadius = 17
    }
}

