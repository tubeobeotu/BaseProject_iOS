import Foundation
import UIKit

enum PhatTrienMoiDVCDStatus {
    case unknown
    case moiGiao
    case daTiepNhan
    case dangThucHien
    case tamDung
    case sapHetHan
    case quaHan
    case congViecQuaHanThieuLyDoTon
    
    static var all: [PhatTrienMoiDVCDStatus] = [unknown, moiGiao, daTiepNhan, dangThucHien, tamDung, sapHetHan, quaHan, congViecQuaHanThieuLyDoTon]
    
    var text: String {
        get {
            switch self {
            case .unknown:
                return "status".localizedString()
            case .moiGiao:
                return "newDelivery".localizedString()
            case .daTiepNhan:
                return "receptionFinished".localizedString()
            case .dangThucHien:
                return "processing".localizedString()
            case .tamDung:
                return "pause".localizedString()
            case .sapHetHan:
                return "expired".localizedString()
            case .quaHan:
                return "outOfDate".localizedString()
            case .congViecQuaHanThieuLyDoTon:
                return "delinquentWorkMissingReasons".localizedString()
            }
        }
    }
    
    var key: String {
        get {
            switch self {
            case .unknown:
                return ""
            case .moiGiao:
                return ""
            case .daTiepNhan:
                return ""
            case .dangThucHien:
                return ""
            case .tamDung:
                return ""
            case .sapHetHan:
                return ""
            case .quaHan:
                return ""
            case .congViecQuaHanThieuLyDoTon:
                return ""
            }
        }
    }
}


