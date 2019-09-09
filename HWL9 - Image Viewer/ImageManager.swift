import Foundation
import UIKit

class ImageManager: NSObject{
    static let shared = ImageManager()
    private override init() {}
    
    var index = 0
    var firstImage = UIImageView()
    var secondImage = UIImageView()
    var thirdImage = UIImageView()
    var imageBase = [UIImageView]()
    
    
    func makeBase() -> [UIImageView] {
        
        self.firstImage.image = #imageLiteral(resourceName: "amber")
        self.secondImage.image = #imageLiteral(resourceName: "greenRing")
        self.thirdImage.image = #imageLiteral(resourceName: "woodenRing")
        imageBase.append(self.firstImage)
        imageBase.append(self.secondImage)
        imageBase.append(self.thirdImage)
        return imageBase
    }
    
    
    func goPrevious() -> Int{
        let size = self.imageBase.count
        self.index-=1
        if self.index != -1 {
            return self.index
        }else{
            self.index = size-1
            return self.index
        }
    }
    
    func goNext() -> Int{
        let size = self.imageBase.count
        self.index+=1
        if self.index != size{
            return index
        }else{
            self.index = 0
            return index
        }
    }
   
    
}
