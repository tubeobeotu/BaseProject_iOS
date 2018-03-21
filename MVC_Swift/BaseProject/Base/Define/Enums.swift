//
//  Enums.swift
//  VSmart
//
//  Created by Administrator on 9/22/17.
//  Copyright © 2017 ITSOL. All rights reserved.
//

import Foundation
import UIKit

enum UserType {
    case staffCongTy
    case staffKhuVuc
    case staffTinh
    case staffHuyen
    case keyCongTy
    case keyKhuVuc
    case keyTinh
    case keyHuyen
    
    static func rawUserType(roleId: Int, levelUser: Int) -> UserType? {
        switch (roleId, levelUser) {
        case (0, 1):
            return staffCongTy
        case (0, 2):
            return staffKhuVuc
        case (0, 3):
            return staffTinh
        case (0, 4):
            return staffHuyen
        case (1, 1):
            return keyCongTy
        case (1, 2):
            return keyKhuVuc
        case (1, 3):
            return keyTinh
        case (1, 4):
            return keyHuyen
        default:
            return nil
        }
    }
    
    static func rawUserTypeFromString(_ string: String?) -> UserType? {
        guard let userTypeString = string else {
            return nil
        }
        
        switch userTypeString {
        case VTLocalizedString.localized(key: "companyEmployee"):
            return staffCongTy
        case VTLocalizedString.localized(key: "regionalEmployee"):
            return staffKhuVuc
        case VTLocalizedString.localized(key: "provincialPersonnel"):
            return staffTinh
        case VTLocalizedString.localized(key: "districtStaff"):
            return staffHuyen
        case VTLocalizedString.localized(key: "companyLeadership"):
            return keyCongTy
        case VTLocalizedString.localized(key: "regionalLeaders"):
            return keyKhuVuc
        case VTLocalizedString.localized(key: "provincialLeadership"):
            return keyTinh
        case VTLocalizedString.localized(key: "districtLeaders"):
            return keyHuyen
        default:
            return nil
        }
    }

    func toString() -> String {
        switch self {
        case .staffCongTy:
            return VTLocalizedString.localized(key: "companyEmployee")
        case .staffKhuVuc:
            return VTLocalizedString.localized(key: "regionalEmployee")
        case .staffTinh:
            return VTLocalizedString.localized(key: "provincialPersonnel")
        case .staffHuyen:
            return VTLocalizedString.localized(key: "districtStaff")
        case .keyCongTy:
            return VTLocalizedString.localized(key: "companyLeadership")
        case .keyKhuVuc:
            return VTLocalizedString.localized(key: "regionalLeaders")
        case .keyTinh:
            return VTLocalizedString.localized(key: "provincialLeadership")
        case .keyHuyen:
            return VTLocalizedString.localized(key: "districtLeaders")
        }
    }
}

enum WorkManagementStatus {
    case unknown
    case quaHan
    case sapHetHan
    case tamDung
    case dangThucHien
    case moiGiao
    case daTiepNhan
    
    
    static var all: [WorkManagementStatus] = [quaHan, sapHetHan, tamDung, dangThucHien, moiGiao, daTiepNhan]
    
//    static func statusForInt(_ int: Int) -> WorkManagementStatus {
//        switch int {
//        case 1:
//            return .cdDaTiepNhan
//        case 2:
//            return .ftTuChoi
//        case 3:
//            return .ftDaGiao
//        case 4:
//            return .ftDaTiepNhan
//        case 5:
//            return .ftDangXuLy
//        case 6:
//            return .ftHoanThanh
//        case 8:
//            return .ftTamDung
//        default:
//            return .unknown
//        }
//    }
    
    static func statusFromString(_ string: String) -> WorkManagementStatus {
        switch string.lowercased() {
        case "quá hạn", "qua han":
            return .quaHan
        case "sắp hết hạn", "sap het han":
            return .sapHetHan
        case "tạm dừng", "tam dung":
            return .tamDung
        case "đang thực hiện", "dang thuc hien":
            return .dangThucHien
        case "mới giao", "moi giao":
            return .moiGiao
        case "đã tiếp nhận", "da tiep nhan":
            return .daTiepNhan
        default:
            return .unknown
        }
    }
    
    var text: String {
        get {
            switch self {
            case .unknown:
                return VTLocalizedString.localized(key: "status")
            case .quaHan:
                return VTLocalizedString.localized(key: "outOfDate")
            case .sapHetHan:
                return VTLocalizedString.localized(key: "expired")
            case .tamDung:
                return VTLocalizedString.localized(key: "pause")
            case .dangThucHien:
                return VTLocalizedString.localized(key: "processing")
            case .moiGiao:
                return VTLocalizedString.localized(key: "newDelivery")
            case .daTiepNhan:
                return VTLocalizedString.localized(key: "receptionFinished")
            }
        }
    }
    
    var color: UIColor {
        get {
            switch self {
            case .unknown:
                return UIColor.clear
            case .quaHan:
                return UIColor.colorWithHexString("#F44336")
            case .sapHetHan:
                return UIColor.colorWithHexString("#FF9800")
            case .tamDung:
                return UIColor.colorWithHexString("#9575CD")
            case .dangThucHien:
                return UIColor.colorWithHexString("#1EAE98")
            case .moiGiao:
                return UIColor.colorWithHexString("#2F85F6")
            case .daTiepNhan:
                return UIColor.colorWithHexString("#7CB342")
            }
        }
    }
    
    var key: String {
        get {
            switch self {
            case .unknown:
                return ""
            case .quaHan:
                return "6"
            case .sapHetHan:
                return "5"
            case .tamDung:
                return "9"
            case .dangThucHien:
                return "3"
            case .moiGiao:
                return "8"
            case .daTiepNhan:
                return "2"
            }
        }
    }
}

enum WorkManagementType {
    case unknown//
    case xuLySuCoCoDinh//
    case phatTrienMoiDVCD//
    case congViecCR//delete
    case giamSatNeNepQLCTKT//
    case xuLySuCoVoTuyen//
    case phatTrienHaTangTram//Xử lý sự cố DVGP
    case congViecQuyTrinhGNOC//
    
    enum subType {
        case unknown
        case accountForXuLySuCoCoDinh
        case phoneNumberForXuLySuCoCoDinh
        case accountForPhatTrienMoiDVCD
        case phoneNumberForPhatTrienMoiDVCD
        
        static var allForXuLySuCoCoDinh: [WorkManagementType.subType] = [accountForXuLySuCoCoDinh, phoneNumberForXuLySuCoCoDinh]
        static var allForPhatTrienMoiDVCD: [WorkManagementType.subType] = [accountForPhatTrienMoiDVCD, phoneNumberForPhatTrienMoiDVCD]
        static var allForCongViecCR: [WorkManagementType.subType] = [unknown]
        static var allForGiamSatNeNepQLCTKT: [WorkManagementType.subType] = [unknown]
        static var allForXuLySuCoVoTuyen: [WorkManagementType.subType] = [unknown]
        static var allForPhatTrienHaTangTram: [WorkManagementType.subType] = [unknown]
        static var allForCongViecQuyTrinhGNOC: [WorkManagementType.subType] = [unknown]
        
        var text: String {
            get {
                switch self {
                case .unknown:
                    return VTLocalizedString.localized(key: "unchecked")
                case .accountForXuLySuCoCoDinh:
                    return VTLocalizedString.localized(key: "account")
                case .phoneNumberForXuLySuCoCoDinh:
                    return VTLocalizedString.localized(key: "phoneNumber")
                case .accountForPhatTrienMoiDVCD:
                    return VTLocalizedString.localized(key: "account")
                case .phoneNumberForPhatTrienMoiDVCD:
                    return VTLocalizedString.localized(key: "phoneNumber")
                }
            }
        }
        
        var key: String {
            get {
                switch self {
                case .unknown:
                    return ""
                case .accountForXuLySuCoCoDinh:
                    return "0"
                case .phoneNumberForXuLySuCoCoDinh:
                    return "1"
                case .accountForPhatTrienMoiDVCD:
                    return "0"
                case .phoneNumberForPhatTrienMoiDVCD:
                    return "1"
                }
            }
        }
    }
    
    static var all: [WorkManagementType] {
        get {
            if let userType = LocalUser.shared.currentUser?.userType {
                switch userType {
                case .keyCongTy, .keyKhuVuc, .staffKhuVuc :
//                    return [unknown, xuLySuCoCoDinh, phatTrienMoiDVCD, giamSatNeNepQLCTKT, xuLySuCoVoTuyen, phatTrienHaTangTram, congViecQuyTrinhGNOC]
                    return [unknown, congViecQuyTrinhGNOC]
                default:
                    return [unknown, congViecQuyTrinhGNOC]
                }
            } else {
                return [unknown]
            }
        }
    }
    
    var text: String {
        get {
            switch self {
            case .unknown:
                return VTLocalizedString.localized(key: "chooseTypeWork")
            case .xuLySuCoCoDinh:
                return VTLocalizedString.localized(key: "fixedTroubleshooting")
            case .phatTrienMoiDVCD:
                return VTLocalizedString.localized(key: "newDevelopmentDVCD")
            case .congViecCR:
                return VTLocalizedString.localized(key: "implementationCRImpact")
            case .giamSatNeNepQLCTKT:
                return VTLocalizedString.localized(key: "followTheRulesQLCTKT")
            case .xuLySuCoVoTuyen:
                return VTLocalizedString.localized(key: "troubleshootWireless")
            case .phatTrienHaTangTram:
                return VTLocalizedString.localized(key: "developmentOfStationInfrastructure")
            case .congViecQuyTrinhGNOC:
                return VTLocalizedString.localized(key: "workProcedureGNOC")
            }
        }
    }
    
    var key: String {
        get {
            switch self {
            case .unknown:
                return "unknown"
            case .xuLySuCoCoDinh:
                return "1"
            case .phatTrienMoiDVCD:
                return "2"
            case .congViecCR:
                return "3"
            case .giamSatNeNepQLCTKT:
                return "5"
            case .xuLySuCoVoTuyen:
                return "6"
            case .phatTrienHaTangTram:
                return "7"
            case .congViecQuyTrinhGNOC:
                return "8"
            }
        }
    }
}

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
                return VTLocalizedString.localized(key: "status")
            case .moiGiao:
                return VTLocalizedString.localized(key: "newDelivery")
            case .daTiepNhan:
                return VTLocalizedString.localized(key: "receptionFinished")
            case .dangThucHien:
                return VTLocalizedString.localized(key: "processing")
            case .tamDung:
                return VTLocalizedString.localized(key: "pause")
            case .sapHetHan:
                return VTLocalizedString.localized(key: "expired")
            case .quaHan:
                return VTLocalizedString.localized(key: "outOfDate")
            case .congViecQuaHanThieuLyDoTon:
                return VTLocalizedString.localized(key: "delinquentWorkMissingReasons")
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

enum SupervisorType {
    case mobile
    case transmission
    case ip
    case television
    
    enum mobileType {
        case matDien
        case dangChayMayNo
        case mayNoChuaDung
        case canNguonDC
        case loiTram
        case canhBaoNgoai
        case downCellMatLuong
        case suyGiamChatLuongMang
        
        static var all: [SupervisorType.mobileType] = [matDien, dangChayMayNo, mayNoChuaDung, canNguonDC, loiTram, canhBaoNgoai, downCellMatLuong, suyGiamChatLuongMang]
        
        var text: String {
            get {
                switch self {
                case .matDien:
                    return VTLocalizedString.localized(key: "powerLoss")
                case .dangChayMayNo:
                    return VTLocalizedString.localized(key: "runningEngineExplodes")
                case .mayNoChuaDung:
                    return VTLocalizedString.localized(key: "unusedExplosives")
                case .canNguonDC:
                    return VTLocalizedString.localized(key: "sourceOutageDC")
                case .loiTram:
                    return VTLocalizedString.localized(key: "stationError")
                case .canhBaoNgoai:
                    return VTLocalizedString.localized(key: "externalSecurity")
                case .downCellMatLuong:
                    return VTLocalizedString.localized(key: "downCellLostStream")
                case .suyGiamChatLuongMang:
                    return VTLocalizedString.localized(key: "downTime")
                }
            }
        }

        var key: String {
            get {
                switch self {
                case .matDien:
                    return VTLocalizedString.localized(key: "mobility-powerFailure")
                case .dangChayMayNo:
                    return VTLocalizedString.localized(key: "mobility-runningTheEngine")
                case .mayNoChuaDung:
                    // Todo: tiep.vu
                    return VTLocalizedString.localized(key: "unusedExplosives")
                case .canNguonDC:
                    return VTLocalizedString.localized(key: "mobilityStationError")
                case .loiTram:
                    return VTLocalizedString.localized(key: "mobility-powerFailure")
                case .canhBaoNgoai:
                    return VTLocalizedString.localized(key: "mobilityExternalWarnings")
                case .downCellMatLuong:
                    return VTLocalizedString.localized(key: "mobilityDowncellLoseFlow")
                case .suyGiamChatLuongMang:
                    return VTLocalizedString.localized(key: "mobilityDeclineInNetworkQuality")
                }
            }
        }
    }

    enum transmissionType {
        case dutCap
        case suyHaoSDH
        case matGiamSatViba
        case suyHaoViba
        
        static var all: [SupervisorType.transmissionType] = [dutCap, suyHaoSDH, matGiamSatViba, suyHaoViba]
        
        var text: String {
            get {
                switch self {
                case .dutCap:
                    return VTLocalizedString.localized(key: "brokenCable")
                case .suyHaoSDH:
                    return VTLocalizedString.localized(key: "depletionSDH")
                case .matGiamSatViba:
                    return VTLocalizedString.localized(key: "lostMonitoringViba")
                case .suyHaoViba:
                    return VTLocalizedString.localized(key: "lossViba")
                }
            }
        }

        var key: String {
            get {
                switch self {
                case .dutCap:
                    return "Truyendan_Dutcap"
                case .suyHaoSDH:
                    return "Truyendan_SuyhaoSDH"
                case .matGiamSatViba:
                    return "Viba_Matgiamsat"
                case .suyHaoViba:
                    return "Viba_Suyhao"
                }
            }
        }
    }
    
    enum ipType {
        case dutCap
        case downNode
        case suyHao
        case loiThietBi
        
        static var all: [SupervisorType.ipType] = [dutCap, downNode, suyHao, loiThietBi]
        
        var text: String {
            get {
                switch self {
                case .dutCap:
                    return VTLocalizedString.localized(key: "Đứt cáp")
                case .downNode:
                    return VTLocalizedString.localized(key: "Down Node")
                case .suyHao:
                    return VTLocalizedString.localized(key: "Suy hao")
                case .loiThietBi:
                    return VTLocalizedString.localized(key: "Lỗi thiết bị")
                }
            }
        }
        
        var key: String {
            get {
                switch self {
                case .dutCap:
                    return "IP_Dutcap"
                case .downNode:
                    return "IP_Downnode"
                case .suyHao:
                    return "IP_Suyhao"
                case .loiThietBi:
                    return "IP_Loithietbi"
                }
            }
        }
    }
    
    enum televisionType {
        case loiCongSuat
        case canhBaoMucTinHieuRF
        case canhBaoNguon
        case canhBaoNhietDo
        case loiThietBi
        
        static var all: [SupervisorType.televisionType] = [loiCongSuat, canhBaoMucTinHieuRF, canhBaoNguon, canhBaoNhietDo, loiThietBi]
        
        var text: String {
            get {
                switch self {
                case .loiCongSuat:
                    return VTLocalizedString.localized(key: "Lỗi công suất")
                case .canhBaoMucTinHieuRF:
                    return VTLocalizedString.localized(key: "Cảnh báo mức tín hiệu RF")
                case .canhBaoNguon:
                    return VTLocalizedString.localized(key: "Cảnh báo nguồn")
                case .canhBaoNhietDo:
                    return VTLocalizedString.localized(key: "Cảnh báo nhiệt độ")
                case .loiThietBi:
                    return VTLocalizedString.localized(key: "Lỗi thiết bị")
                }
            }
        }
        
        var key: String {
            get {
                switch self {
                case .loiCongSuat:
                    return "BRCD_Loicongsuat"
                case .canhBaoMucTinHieuRF:
                    return "BRCD_CanhbaotinhieuRF"
                case .canhBaoNguon:
                    return "BRCD_Canhbaonguon"
                case .canhBaoNhietDo:
                    return "BRCD_Canhbaonhietdo"
                case .loiThietBi:
                    return "BRCD_Loithietbi"
                }
            }
        }
    }
    
    static var all: [SupervisorType] = [mobile, transmission, ip, television]
    
    var text: String {
        get {
            switch self {
            case .mobile:
                return VTLocalizedString.localized(key: "Di động")
            case .transmission:
                return VTLocalizedString.localized(key: "Truyền dẫn")
            case .ip:
                return VTLocalizedString.localized(key: "IP")
            case .television:
                return VTLocalizedString.localized(key: "Truyền hình")
            }
        }
    }
}

enum NIMS {
    case aon
    case gpon
    case ngoaiviGpon
    
    static var all: [NIMS] = [aon, gpon, ngoaiviGpon]
    
    var text: String {
        get {
            switch self {
            case .aon:
                return VTLocalizedString.localized(key: "Hiệu suất thiết bị AON")
            case .gpon:
                return VTLocalizedString.localized(key: "Hiệu suất thiết bị GPON")
            case .ngoaiviGpon:
                return VTLocalizedString.localized(key: "Hiệu suất sử dụng ngoại vi GPON")
            }
        }
    }
}

enum NetWorkType {
    case for2G
    case for3G
    
    static var all: [NetWorkType] = [for2G, for3G]
    
    enum subType {
        case CDR
        case CSSR
        case CS_CDR
        case CS_CSSR
        case PS_CSSR
        
        static var allFor2G: [NetWorkType.subType] = [CDR, CSSR]
        static var allFor3G: [NetWorkType.subType] = [CS_CDR, CS_CSSR, PS_CSSR]
        
        var text: String {
            get {
                switch self {
                case .CDR:
                    return "CDR"
                case .CSSR:
                    return "CSSR"
                case .CS_CDR:
                    return "CS CDR"
                case .CS_CSSR:
                    return "CS CSSR"
                case .PS_CSSR:
                    return "PS CSSR"
                }
            }
        }
        
        var key: String {
            get {
                switch self {
                case .CDR:
                    return "CDR"
                case .CSSR:
                    return "CSSR"
                case .CS_CDR:
                    return "CS CDR"
                case .CS_CSSR:
                    return "CS CSSR"
                case .PS_CSSR:
                    return "PS CSSR"
                }
            }
        }
    }
    
    var text: String {
        get {
            switch self {
            case .for2G:
                return "2G"
            case .for3G:
                return "3G"
            }
        }
    }
    
    var key: String {
        get {
            switch self {
            case .for2G:
                return "2G"
            case .for3G:
                return "3G"
            }
        }
    }
    
    var intKey: String {
        get {
            switch self {
            case .for2G:
                return "2"
            case .for3G:
                return "3"
            }
        }
    }
}

enum StationKpiType {
    case forStatus
    case forCheckPing
    case forCheckConfiguration
    case forCheckIntegration
    
    static var all: [StationKpiType] = [forStatus, forCheckPing, forCheckConfiguration, forCheckIntegration]
    
    var text: String {
        get {
            switch self {
            case .forStatus:
                return VTLocalizedString.localized(key: "Tra cứu trạng thái")
            case .forCheckPing:
                return VTLocalizedString.localized(key: "Ping từ MME đến Ip Service eNodeB")
            case .forCheckConfiguration:
                return VTLocalizedString.localized(key: "Kiểm tra cấu hình Interface đấu eNodeB")
            case .forCheckIntegration:
                return VTLocalizedString.localized(key: "Kiểm tra tích hợp")
            }
        }
    }
}

enum SearchCell {
    case for2G
    case for3G
    case for4G
    
    static var all: [SearchCell] = [for2G, for3G, for4G]
    
    var text: String {
        get {
            switch self {
            case .for2G:
                return "2G"
            case .for3G:
                return "3G"
            case .for4G:
                return "4G"
            }
        }
    }
}

enum SearchKPI {
    case for2G
    case for3G
    
    static var all: [SearchKPI] = [for2G, for3G]
    
    enum subType {
        case normal
        case peak
        case gprs
        case badtime
        case lowspeed
        case levelDistrict
        case levelCell
        
        static var allFor2G: [SearchKPI.subType] = [normal, peak, gprs, badtime]
        static var allFor3G: [SearchKPI.subType] = [normal, peak, lowspeed, badtime]
        static var level: [SearchKPI.subType] = [levelDistrict, levelCell]
        
        var text: String {
            get {
                switch self {
                case .normal:
                    return "NORMAL"
                case .peak:
                    return "PEAK"
                case .gprs:
                    return "GPRS"
                case .badtime:
                    return VTLocalizedString.localized(key: "Giờ tồi nhất")
                case .lowspeed:
                    return VTLocalizedString.localized(key: "Tốc độ thấp")
                case .levelDistrict:
                    return VTLocalizedString.localized(key: "Mức huyện")
                case .levelCell:
                    return VTLocalizedString.localized(key: "Mức Cell")
                }
            }
        }
    }
    
    var text: String {
        get {
            switch self {
            case .for2G:
                return "2G"
            case .for3G:
                return "3G"
            }
        }
    }
}

enum KPIReturn {
    case unknown
    case normal2G
    case peak2G
    case gprs2G
    case badtime2G
    case normal3G
    case peak3G
    case slowspeed3G
    case badtime3G
    
    var title: Array<Any> {
        get {
            switch self {
            case .unknown:
                return []
            case .normal2G:
                return ["TCH Traffic", "CDR", "HOSR", "CSSR"]
            case .peak2G:
                return ["SCR", "TCH Traffic", "CDR", "HOSR", "TCR", "CSSR"]
            case .gprs2G:
                return ["DTDR", "DL LLC Data Volume", "UL LLC Data Volume", "DTESR", "UTESR", "UTDR"]
            case .badtime2G:
                return ["SCR", "CDR", "TCR", "CSSR"]
            case .normal3G:
                return ["CS CDR", "CS CSSR", "PS CDR", "PS traffic", "PS CSSR", "Voice traffic"]
            case .peak3G:
                return ["CS RAB CR", "CS CDR", "CS CSSR", "PS CDR", "PS CSSR", "PS RAB CR"]
            case .slowspeed3G:
                return ["HSUPA UNAVAIL TIME", "HSDPA UNAVAIL TIME", VTLocalizedString.localized(key: "% số màu sử dụng điều chế 64 QAM"), VTLocalizedString.localized(key: "% số màu sử dụng điều chế 16 QAM"), VTLocalizedString.localized(key: "% số màu sử dụng >10 code SF16")]
            case .badtime3G:
                return ["CS CSSR", "PS CSSR", "CS RAB CR", "PS RAB CR", "PS CDR", "CS CDR"]
            }
        }
    }
    
    var key: String {
        get {
            switch self {
            case .unknown:
                return ""
            case .normal2G:
                return "NORMAL"
            case .peak2G:
                return "PEAK"
            case .gprs2G:
                return "GPRS"
            case .badtime2G:
                return "BADHOUR"
            case .normal3G:
                return "NORMAL"
            case .peak3G:
                return "PEAK"
            case .slowspeed3G:
                return "TRAFFIC"
            case .badtime3G:
                return "BADHOUR"
            }
        }
    }
}

enum NewsAnnounce {
    case UnRead
    case Read
    
    static var all = [UnRead, Read]
    
    var text: String {
        get {
            switch self {
            case .UnRead:
                return "Chưa đọc"
            case .Read:
                return "Đã đọc"
            }
        }
    }
}
enum CheckListCoDienState {
    case OK
    case NOK
    
    static var all = [NOK, OK]
    
    var text: String {
        get {
            switch self {
            case .OK:
                return "OK"
            case .NOK:
                return "NOK"
            }
        }
    }
}
enum Utility_TestAndSurveyType: Int
{
    case UnCheck = 0
    case MoiTao
    case DaPass
    case KhongPass
    case DaKhaoSat
    static var all = [UnCheck, MoiTao, DaPass, KhongPass, DaKhaoSat]
    var text: String {
        get {
            switch self {
            case .MoiTao :
                return VTLocalizedString.localized(key: "Mới tạo").localizedString()
            case .DaPass :
                return VTLocalizedString.localized(key: "Đã pass").localizedString()
            case .KhongPass :
                return VTLocalizedString.localized(key: "Không pass").localizedString()
            case .DaKhaoSat :
                return VTLocalizedString.localized(key: "Đã khảo sát").localizedString()
            default :
                return "--Select--".localizedString()
                
            }
            
        }
    }
}
enum MenuType: Int {
    case LogOut = -1
    case UnKown = -100
    case QuanLyCongViec = 1000
    case GiamSatChuDong = 2000
    case DashBoardGSTHCB = 2001
    case TraCuuCTCB = 2002
    case TacDongXulyLoi = 3000
    case QLCLDichVuKhachHangQos = 3002
    case DoiPostRestMac = 3003
    case TraCuuHaTang = 3004
    case DoiThietBiUCTT = 3005
    case DoiThietBiBaoHanh = 3006
    case CongViecKCSThietBi = 3008
    case TraCuuTicketCC = 3009
    case SwapVendorThietBi = 3010
    case TraCuuDiemTonTai = 3011
    case ThongTinHieuSuatTaiNguyenTrenNIMS = 3012
    case CapNhatPortSai = 3013
    case TraCuuKPI = 4000
    case TraCuuKPI_BRCD = 4001
    case TraCuuCellVuotTarget = 4002
    case TraCuuCuCellToi = 4003
    case TraCuuCanhBaoCell = 4004
    case QuanlyThongTinTram2g3g4g = 4005
    case TraCuuKPI_Gnoc = 4006
    case QuanLyThongTinVungLom = 4008
    case TraCuuThongTinSuKienLeHoi = 4009
    case TraCuuThongTinTramMoi = 4010
    case TraCuuSubKPI = 4011
    case BanDoTram = 4012
    case TraCuuTrangThaiTram4g = 4015
    case TraCuuKPITram = 4016
    case TraCuuTongLuongKhoan = 4017
    case VatTuTainguyen = 5000
    case TraCuuKhoCaNhan = 5001
    case HangHoaToDoi = 5002
    case TraCuuVatTuThietBi = 5003
    case TraCuuThongTinNhaTram = 5004
    case TraCuuThongTinHaTangThueBao = 5005
    case TraCuuTaiNguyenDVCD = 5006
    case TraCuuLinkKetNoiDenNodeThueBao = 5007
    case TraCuuThueBaoBCCS = 5008
    case NhapThongTinCoDien = 5009
    case TraCuuKhoHuyen = 5010
    case NhapThongTinCoDien2 = 5011
    case TienIch = 6000
    case BaoCaoCongViec = 6001
    case ChupAnhBaoDuong = 6002
    case ThongTinVersion = 6003
    case QuanLyDichVuCDBR = 6004
    case TaoCongViecKiemTra = 6005
    case TraCuuThongTinKTTS = 6006
    case GiamSatMucThuDauXaGanViBa = 6008
    case SwapIPPhone = 6009
    case KiemTraKhaoSat = 6010
    case GiaoKetCuoi = 6011
    case CongViecTrenBanDo = 6012
    case GhepBoCoDien = 6013
    case WOBaoMat_Hong_KhongSuDung = 6014
    case QuanLyCongViecPhatSinh = 6015
    case TraCuuMaLoi = 6016
    case QuanLyTuyenDaGhepLink = 6017
    case ChamDiemAHI = 6018
    case DangKiRaVaoTram = 6019
    case ViewDutTuyen = 6020
    case Chat = 6030
    
    var text: String {
        get {
            switch self {
            case .LogOut :
                return VTLocalizedString.localized(key: "Đăng xuất")
            default :
                return ""
                
            }

        }
    }
    
    var image: String {
        get {
            switch self {
            case .GiamSatChuDong:
                return "left-menu-supervisor"
            case .QuanLyCongViec:
                return "left-menu-work-management"
            case .TacDongXulyLoi:
                return "left-menu-error-handling"
            case .TraCuuKPI:
                return "left-menu-searching-kpi"
            case .VatTuTainguyen:
                return "left-menu-resource"
            case .TienIch:
                return "left-menu-utility"
            case .LogOut:
                return "left-menu-signout"
            case .Chat:
                return "left-menu-signout"
            default:
                return ""
            }
        }
    }
}

enum OfferState : Int {
    case Unknown = 0
    case ChoPheDuyet = 1
    case DongY = 2
    case TuChoi = 3
    
    static var all = [Unknown, ChoPheDuyet, DongY, TuChoi]
    
    var text: String {
        get {
            switch self {
            case .Unknown:
                return VTLocalizedString.localized(key: "chooseUppercase")
            case .ChoPheDuyet:
                return VTLocalizedString.localized(key: "waitingForApproval")
            case .DongY:
                return VTLocalizedString.localized(key: "agree")
            case .TuChoi:
                return VTLocalizedString.localized(key: "refuse")
            default:
                return ""
            }
        }
    }
}
enum WO_AssetStationReasonType : Int {
//    case UnCheck = 0
    case WO_AssetStationReasonType_ThienTai = 1
    case WO_AssetStationReasonType_ChayNo
    case WO_AssetStationReasonType_MatCap
    
    static var all = [WO_AssetStationReasonType_ThienTai, WO_AssetStationReasonType_ChayNo, WO_AssetStationReasonType_MatCap]
    
    var text: String {
        get {
            switch self {
            case .WO_AssetStationReasonType_ThienTai:
                return "Thiên tai".localizedString()
            case .WO_AssetStationReasonType_ChayNo:
                return "Cháy nổ".localizedString()
            case .WO_AssetStationReasonType_MatCap:
                return "Mất cắp".localizedString()
//            default:
//                return "--Lựa chọn--".localizedString()
            }
        }
    }
}
enum NotifyWO : Int {
    case UnCheck = 0
    case TS_BAO_MAT
    case TS_THU_HOI_BAO_HONG
    case TS_THU_HOI_KHONG_SU_DUNG
    
    static var all = [TS_BAO_MAT, TS_THU_HOI_BAO_HONG, TS_THU_HOI_KHONG_SU_DUNG]
    
    var text: String {
        get {
            switch self {
            case .TS_BAO_MAT:
                return "WO báo mất".localizedString()
            case .TS_THU_HOI_BAO_HONG:
                return "WO báo hỏng".localizedString()
            case .TS_THU_HOI_KHONG_SU_DUNG:
                return "WO báo không sử dụng".localizedString()
            default:
                return "--Lựa chọn--".localizedString()
            }
        }
    }
    
    //key no need no transtate
    var key: String {
        get {
            switch self {
            case .TS_BAO_MAT:
                return "TS_BAO_MAT"
            case .TS_THU_HOI_BAO_HONG:
                return "TS_THU_HOI_BAO_HONG"
            case .TS_THU_HOI_KHONG_SU_DUNG:
                return "TS_THU_HOI_KHONG_SU_DUNG"
            default:
                return ""
            }
        }
    }
}
enum WorkIncurredType : Int {
    case Unknown = 0
    
    case Tram = 1
    case Tuyen = 2
    
    static var all = [ Tram, Tuyen]
    
    var text: String {
        get {
            switch self {
            case .Tuyen:
                return VTLocalizedString.localized(key: "Tuyến")
            case .Tram:
                return VTLocalizedString.localized(key: "Trạm")
            case .Unknown:
                return VTLocalizedString.localized(key: "chooseUppercase")
            }
        }
    }
}

