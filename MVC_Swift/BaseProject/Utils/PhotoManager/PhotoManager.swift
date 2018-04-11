//pod "QBImagePickerController"
//#import <QBImagePickerController/QBImagePickerController.h>
//<key>NSCameraUsageDescription</key>    <string>Ứng dụng muốn truy cập camera của bạn</string>
//<key>NSPhotoLibraryUsageDescription</key>    <string>Ứng dụng muốn truy cập thư việc ảnh</string>

//self.photoManager.delegate = self
//self.photoManager.showOptions()
//extension XuLyCVPhaiKhacPhucTrongTramViewController : PhotoManagerDelegate
//{
//    func didSelectImage(image: UIImage) {
//
//    }
//
//    func didSelectImages(images: [Image]) {
//        if list.indices.contains(self.currentIndex) {
//            list[self.currentIndex] = images.first!
//        } else {
//            list.append(images.first!)
//        }
//        self.tableView.reloadRows(at: [IndexPath.init(item: self.currentIndex, section: 0)], with: .fade)
//    }
//
//    func presentVC() -> UIViewController {
//        return self
//    }
//}
import UIKit
import QBImagePickerController
import AssetsLibrary

protocol PhotoManagerDelegate
{
    func didSelectImages(images: [Image])
    func didSelectImage(image: UIImage)
    func presentVC() -> UIViewController
}
struct Image
{
    var image:UIImage!
    var name:String!
}
enum PhotoManagerType: NSInteger
{
    case All
    case Camera
    case Library
}
class PhotoManager: NSObject {
    var delegate:PhotoManagerDelegate?
    var maxiumImages:Int = 1
    private var type:PhotoManagerType = .All
    private lazy var imageLibraryPickerController:UIImagePickerController? = {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imageLibraryPickerController = UIImagePickerController()
            imageLibraryPickerController.allowsEditing = true
            imageLibraryPickerController.sourceType = .photoLibrary
            imageLibraryPickerController.delegate = self
            return imageLibraryPickerController
        }
        return nil
        
    }()
    private lazy var imageTakePictureController:UIImagePickerController? = {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imageTakePictureController = UIImagePickerController()
            imageTakePictureController.allowsEditing = true
            imageTakePictureController.sourceType = .camera
            imageTakePictureController.delegate = self
            return imageTakePictureController
        }
        return nil
        
    }()
    
    func jpegImage(image: UIImage, maxSize: Int, minSize: Int, times: Int) -> Data? {
        var maxQuality: CGFloat = 1.0
        var minQuality: CGFloat = 0.0
        var bestData: Data?
        for _ in 1...times {
            let thisQuality = (maxQuality + minQuality) / 2
            guard let data = UIImageJPEGRepresentation(image, thisQuality) else { return nil }
            let thisSize = data.count
            if thisSize > maxSize {
                maxQuality = thisQuality
            } else {
                minQuality = thisQuality
                bestData = data
                if thisSize > minSize {
                    return bestData
                }
            }
        }
        return bestData
    }
    
    override init() {
        super.init()
    }
    convenience init(maxiumImages: Int) {
        self.init()
        self.maxiumImages = maxiumImages
    }
    convenience init(maxiumImages: Int, type: PhotoManagerType) {
        self.init(maxiumImages: maxiumImages)
        self.type = type
    }
//    func setupImagePicker()
//    {
//        imageLibraryPickerController = QBImagePickerController()
//        imageLibraryPickerController.allowsMultipleSelection = true
//        imageLibraryPickerController.showsNumberOfSelectedAssets = false
//        imageLibraryPickerController.mediaType = .image
//        imageLibraryPickerController.delegate = self
//        imageLibraryPickerController.maximumNumberOfSelection = UInt(maxiumImages)
//    }
    func showOptions()
    {
//        if(self.type == .All || self.type == .Library)
//        {
//            self.setupImagePicker()
//        }
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Thêm ảnh".localizedString(), message: nil, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "BỎ QUA".localizedString(), style: .default) { action -> Void in
            //Just dismiss the action sheet
        }
        let takePhoto: UIAlertAction = UIAlertAction(title: "CHỤP ẢNH".localizedString(), style: .default) { action -> Void in
            self.delegate?.presentVC().present(self.imageTakePictureController!, animated: true, completion: nil)
        }
        let selecFromLib: UIAlertAction = UIAlertAction(title: "CHỌN ẢNH TỪ THƯ VIỆN".localizedString(), style: .default) { action -> Void in
            self.delegate?.presentVC().present(self.imageLibraryPickerController!, animated: true, completion: nil)
        }
        if((self.imageTakePictureController) != nil && (self.type == .All || self.type == .Camera))
        {
           actionSheetController.addAction(takePhoto)
        }
        actionSheetController.addAction(selecFromLib)
        actionSheetController.addAction(cancelAction)
        if(self.type == .All)
        {
            self.delegate?.presentVC().present(actionSheetController, animated: true, completion: nil)
        }else if (self.type == .Library)
        {
            self.delegate?.presentVC().present(self.imageLibraryPickerController!, animated: true, completion: nil)
        }else
        {
            self.delegate?.presentVC().present(self.imageTakePictureController!, animated: true, completion: nil)
        }
        
    }
    
}

//extension UIImage {
//    func resized(withPercentage percentage: CGFloat) -> UIImage? {
//        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
//        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
//        defer { UIGraphicsEndImageContext() }
//        draw(in: CGRect(origin: .zero, size: canvasSize))
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }
//    func resized(toWidth width: CGFloat) -> UIImage? {
//        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
//        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
//        defer { UIGraphicsEndImageContext() }
//        draw(in: CGRect(origin: .zero, size: canvasSize))
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }
//}

extension UIImage {
    // MARK: - UIImage+Resize
    func compressTo(_ expectedSizeInKb:Int) -> UIImage? {
        let sizeInBytes = expectedSizeInKb * 1024
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = UIImageJPEGRepresentation(self, compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }
        print("data2 : %@", imgData as Any)
        if let data = imgData {
            if (data.count < sizeInBytes) {
                return UIImage(data: data)
            }
        }
        return nil
    }
}

extension PhotoManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var timeSecond = 0
        if #available(iOS 11.0, *) {
            if let asset = info[UIImagePickerControllerPHAsset] as? PHAsset{
                let dateTaken = asset.creationDate
                print("Date : %@", dateTaken! as NSDate)
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let result = formatter.string(from: date)
                print("Date now : %@", result)
                
                timeSecond = Int(Date().timeIntervalSince(dateTaken!))
                print("So gio : %@", timeSecond)
                
            }else if let assertURL = info[UIImagePickerControllerReferenceURL] as? NSURL {
                let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [assertURL as URL], options: nil)
                if let asset = fetchResult.firstObject {
                    // Here is the date when your image was taken
                    print(asset.creationDate as Any)
                    
                    let dateTaken = asset.creationDate
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let result = formatter.string(from: date)
                    print("Date now : %@", result)
                    
                    timeSecond = Int(Date().timeIntervalSince(dateTaken!))
                    print("So gio : %@", timeSecond)
                }
            }
        } else {
            // Fallback on earlier versions
            print("He Dieu Hanh duoi 11")
            if let assertURL = info[UIImagePickerControllerReferenceURL] as? NSURL {
                let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [assertURL as URL], options: nil)
                if let asset = fetchResult.firstObject {
                    // Here is the date when your image was taken
                    print(asset.creationDate as Any)
                    
                    let dateTaken = asset.creationDate
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let result = formatter.string(from: date)
                    print("Date now : %@", result)
                    
                    timeSecond = Int(Date().timeIntervalSince(dateTaken!))
                    print("So gio : %@", timeSecond)
                }
            }

        }
        
        if timeSecond > 7200 {
            picker.dismiss(animated: true, completion: {
                let actionSheetController: UIAlertController = UIAlertController(title: VTLocalizedString.localized(key: "Thông báo"), message: "Ảnh bạn chọn là ảnh đã chụp quá 2 tiếng trước".localizedString(), preferredStyle: .alert)
                let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                }
                actionSheetController.addAction(cancelAction)
                self.delegate?.presentVC().present(actionSheetController, animated: true, completion: nil)
            })
            
        }else {
            if var image = info[UIImagePickerControllerOriginalImage] as? UIImage
            {
//                jpegImage(image: image, maxSize: 10000, minSize: 10, times: 10)
                let compressingValue:CGFloat = 1.0
                let data1:Data = UIImageJPEGRepresentation(image, compressingValue)!
                if data1.count < (500 * 1024) {
                    
                }else {
                    image = image.compressTo(500)!
                }
                
                print("data1 : %@", data1)
                self.delegate?.didSelectImages(images: [Image.init(image: image, name: "cameraImage.png") ])
                self.delegate?.didSelectImage(image:image)
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
}

extension PhotoManager: QBImagePickerControllerDelegate
{
    
    func qb_imagePickerController(_ imagePickerController: QBImagePickerController!, didFinishPickingAssets assets: [Any]!) {
        var images = [Image]()
        let count = assets.count
        for index in 0 ..< count {
            if let asset = assets[index] as? PHAsset
            {
                let manager = PHImageManager.default()
                manager.requestImageData(for: asset, options: nil, resultHandler: { (imageData, dataUTI, orientation, info) in
                    var name = ""
                    if let validInfo = info
                    {
                        name = (validInfo["PHImageFileURLKey"] as! URL).path
                    }
                    images.append(Image.init(image: UIImage.init(data: imageData!)!, name: name) )
                    if(index == count - 1)
                    {
                        self.delegate?.didSelectImages(images: images)
                        self.delegate?.didSelectImage(image:UIImage.init(data: imageData!)!)
                        imagePickerController.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
        
    }
    func qb_imagePickerControllerDidCancel(_ imagePickerController: QBImagePickerController!) {
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}
