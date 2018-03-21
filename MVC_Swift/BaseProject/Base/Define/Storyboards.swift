//
//  Storyboards.swift
//  VSmart
//
//  Created by Macbook Pro on 9/9/17.
//  Copyright © 2017 ITSOL. All rights reserved.
//

import Foundation
import UIKit

struct Storyboard {
    
}

extension Storyboard {

    struct cellVuotTarget {
        static let cellVuotTarget = UIStoryboard(name: "CellVuotTarget", bundle: nil)
        
        static func cellVuotTargetNavigationController() -> BaseNavigationController {
            return cellVuotTarget.instantiateViewController(withIdentifier: "CellVuotTargetNavigationController") as! BaseNavigationController
        }
    }
    
    struct canhBaoCell {
        static let canhBaoCell = UIStoryboard(name: "CanhBaoCell", bundle: nil)
        
        static func canhBaoCellNavigationController() -> BaseNavigationController {
            return canhBaoCell.instantiateViewController(withIdentifier: "CanhBaoCellNavigationController") as! BaseNavigationController
        }
    }
    
    struct badCell {
        static let badCell = UIStoryboard(name: "BadCell", bundle: nil)
        
        static func badCellNavigationController() -> BaseNavigationController {
            return badCell.instantiateViewController(withIdentifier: "BadCellNavigationController") as! BaseNavigationController
        }
    }
    
    struct chiTietPhieuXuatKho {
        static let chiTietPhieuXuatKho = UIStoryboard(name: "ChiTietPhieuXuatKho", bundle: nil)
        
        static func chiTietPhieuXuatKhoViewController() -> ChiTietPhieuXuatKhoViewController {
            return chiTietPhieuXuatKho.instantiateViewController(withIdentifier: "ChiTietPhieuXuatKhoViewController") as! ChiTietPhieuXuatKhoViewController
        }
    }
    
    struct eventInformation {
        static let eventInformation = UIStoryboard(name: "EventInformation", bundle: nil)
        
        static func eventInformationNavigationController() -> BaseNavigationController {
            return eventInformation.instantiateViewController(withIdentifier: "EventInformationNavigationController") as! BaseNavigationController
        }
    }
    
    struct gnocKpi {
        static let gnocKpi = UIStoryboard(name: "GnocKpi", bundle: nil)
        
        static func gnocKpiStaffNavigationController() -> BaseNavigationController {
            return gnocKpi.instantiateViewController(withIdentifier: "GnocKpiStaffNavigationController") as! BaseNavigationController
        }
        
        static func gnocKpiPGDNavigationController() -> BaseNavigationController {
            return gnocKpi.instantiateViewController(withIdentifier: "GnocKpiPGDNavigationController") as! BaseNavigationController
        }
        
        static func gnocKpiPGDDetailViewController() -> GnocKpiPGDDetailViewController {
            return gnocKpi.instantiateViewController(withIdentifier: "GnocKpiPGDDetailViewController") as! GnocKpiPGDDetailViewController
        }
    }
    
    struct mainSlide {
        static let mainSlide = UIStoryboard(name: "MainSlide", bundle: nil)
        
        static func mainSlideMenuViewController() -> MainSlideMenuViewController {
            return mainSlide.instantiateViewController(withIdentifier: "MainSlideMenuViewController") as! MainSlideMenuViewController
        }
        
        static func leftMenuViewController() -> LeftMenuViewController {
            return mainSlide.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
        }
        
        static func mainLeftMenuNavigationController() -> BaseNavigationController {
            return mainSlide.instantiateViewController(withIdentifier: "MainLeftMenuNavigationController") as! BaseNavigationController
        }
        
        static func mainLeftMenuViewController() -> MainLeftMenuViewController {
            return mainSlide.instantiateViewController(withIdentifier: "MainLeftMenuViewController") as! MainLeftMenuViewController
        }
        
        static func subLeftMenuViewController() -> SubLeftMenuViewController {
            return mainSlide.instantiateViewController(withIdentifier: "SubLeftMenuViewController") as! SubLeftMenuViewController
        }
    }
    
    struct newStationInfo {
        static let newStationInfo = UIStoryboard(name: "NewStationInfo", bundle: nil)
        
        static func newStationInfoNavigationController() -> BaseNavigationController {
            return newStationInfo.instantiateViewController(withIdentifier: "NewStationInfoNavigationController") as! BaseNavigationController
        }
    }
    
    struct nims {
        static let nims = UIStoryboard(name: "NIMS", bundle: nil)
        
        static func nimsNavigationController() -> BaseNavigationController {
            return nims.instantiateViewController(withIdentifier: "NIMSNavigationController") as! BaseNavigationController
        }
    }
    
    struct searchCell {
        static let searchCell = UIStoryboard(name: "SearchCell", bundle: nil)
        
        static func searchCellNavigationController() -> BaseNavigationController {
            return searchCell.instantiateViewController(withIdentifier: "SearchCellNavigationController") as! BaseNavigationController
        }
        
        static func detailSearchCellViewController() -> DetailSearchCellViewController {
            return searchCell.instantiateViewController(withIdentifier: "DetailSearchCellViewController") as!
            DetailSearchCellViewController
        }
    }
    
    struct searchFTUser {
        static let searchFTUser = UIStoryboard(name: "SearchFTUser", bundle: nil)
        
        static func searchFTUserViewController() -> SearchFTUserViewController {
            return searchFTUser.instantiateViewController(withIdentifier: "SearchFTUserViewController") as!
            SearchFTUserViewController
        }
    }
    
    struct searchKPI {
        static let searchKPI = UIStoryboard(name: "SearchKPI", bundle: nil)
        
        static func searchKPINavigationController() -> BaseNavigationController {
            return searchKPI.instantiateViewController(withIdentifier: "SearchKPINavigationController") as! BaseNavigationController
        }
    }
    
    struct stationKPI {
        static let stationKPI = UIStoryboard(name: "StationKPI", bundle: nil)
        
        static func stationKPINavigationController() -> BaseNavigationController {
            return stationKPI.instantiateViewController(withIdentifier: "StationKpiNavigationController") as! BaseNavigationController
        }
    }
    
    //Ban do tram
    struct mapStation {
        static let mapStation = UIStoryboard(name: "MapStation", bundle: nil)
        
        static func mapStationNavigationController() -> BaseNavigationController {
            return mapStation.instantiateViewController(withIdentifier: "MapStationNavigationController") as! BaseNavigationController
        }
    }
    
    struct searchReasonDTO {
        static let searchReasonDTO = UIStoryboard(name: "SearchReasonDTO", bundle: nil)
        
        static func searchReasonDTOByReasonNameViewController() -> SearchReasonDTOByReasonNameViewController {
            return searchReasonDTO.instantiateViewController(withIdentifier: "SearchReasonDTOByReasonNameViewController") as!
            SearchReasonDTOByReasonNameViewController
        }
    }
    struct searchSalary {
        static let searchSalary = UIStoryboard(name: "SearchSalary", bundle : nil)
        
        static func searchSalaryNavigationController() -> BaseNavigationController {
            return searchSalary.instantiateViewController(withIdentifier: "SearchSalaryNavigationController") as! BaseNavigationController
        }
    }
    
    struct signIn {
        static let signIn = UIStoryboard(name: "SignIn", bundle: nil)
        
        static func signInViewController() -> SignInViewController {
            return signIn.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        }

        static func changePasswordViewController() -> ChangePasswordViewController {
            return signIn.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        }
        
        static func forgotPasswordViewController() -> ForgotPasswordViewController {
            return signIn.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        }
    }
    
    struct supervisor {
        static let supervisor = UIStoryboard(name: "Supervisor", bundle: nil)
        
        static func supervisorTabBarNavigationController() -> BaseNavigationController {
            return supervisor.instantiateViewController(withIdentifier: "SupervisorTabBarNavigationController") as! BaseNavigationController
        }
        
        static func detailSupervisorJobViewController() -> DetailSupervisorJobViewController {
            return supervisor.instantiateViewController(withIdentifier: "DetailSupervisorJobViewController") as! DetailSupervisorJobViewController
        }
    }
    
    struct tickHelp {
        static let tickHelp = UIStoryboard(name: "TickHelp", bundle: nil)
        
        static func workManagementTickHelpViewController() -> WorkManagementTickHelpViewController {
            return tickHelp.instantiateViewController(withIdentifier: "WorkManagementTickHelpViewController") as! WorkManagementTickHelpViewController
        }
    }
    
    struct version {
        static let version = UIStoryboard(name: "Version", bundle: nil)
        
        static func versionNavigationController() -> BaseNavigationController {
            return version.instantiateViewController(withIdentifier: "VersionNavigationController") as! BaseNavigationController
        }
    }
    
    struct vmsaLog {
        static let version = UIStoryboard(name: "VMSALog", bundle: nil)
        
        static func workManagementVMSALogViewController() -> WorkManagementVMSALogViewController {
            return version.instantiateViewController(withIdentifier: "WorkManagementVMSALogViewController") as! WorkManagementVMSALogViewController
        }
    }
    
    struct vungLom {
        static let vungLom = UIStoryboard(name: "VungLom", bundle: nil)
        
        static func vungLomNavigationController() -> BaseNavigationController {
            return vungLom.instantiateViewController(withIdentifier: "VungLomNavigationController") as! BaseNavigationController
        }
        
        static func vungLomDetailNavigationController() -> ConcaveViewDetailController {
            return vungLom.instantiateViewController(withIdentifier: "ConcaveViewDetailController") as! ConcaveViewDetailController
        }
    }
    
    struct workDetail {
        static let workDetail = UIStoryboard(name: "WorkDetail", bundle: nil)
        
        static func workManagementJobDetailViewController() -> WorkManagementJobDetailViewController {
            return workDetail.instantiateViewController(withIdentifier: "WorkManagementJobDetailViewController") as! WorkManagementJobDetailViewController
        }
        
        static func workUpdateLinkMapViewController() -> WorkUpdateLinkMapViewController {
            return workDetail.instantiateViewController(withIdentifier: "WorkUpdateLinkMapViewController") as! WorkUpdateLinkMapViewController
        }
        
    }
    
    struct workLog {
        static let workLog = UIStoryboard(name: "WorkLog", bundle: nil)
        
        static func workManagementViewAndAddWorklogViewController() -> WorkManagementViewAndAddWorklogViewController {
            return workLog.instantiateViewController(withIdentifier: "WorkManagementViewAndAddWorklogViewController") as! WorkManagementViewAndAddWorklogViewController
        }
    }
    struct KEDB {
        static let KEDB = UIStoryboard(name: "ShowKEDB", bundle: nil)

        static func WorkManagementShowKEDBViewController() -> WorkManagementShowKEDBViewController {
            return KEDB.instantiateViewController(withIdentifier: "WorkManagementShowKEDBViewController") as! WorkManagementShowKEDBViewController
        }
        
        static func watchKEDBViewController() -> WatchKEDBViewController {
            return KEDB.instantiateViewController(withIdentifier: "WatchKEDBViewController") as! WatchKEDBViewController
        }
        
        static func watchMp3ViewController() -> WatchMp3ViewController {
            return KEDB.instantiateViewController(withIdentifier: "WatchMp3ViewController") as! WatchMp3ViewController
        }
    }
    struct workManagement {
        static let workManagement = UIStoryboard(name: "WorkManagement", bundle: nil)
        
        static func workManagementTabBarNavigationController() -> BaseNavigationController {
            return workManagement.instantiateViewController(withIdentifier: "WorkManagementTabBarNavigationController") as! BaseNavigationController
        }
        
        static func workManagementTabBarController() -> WorkManagementTabBarController {
            return workManagement.instantiateViewController(withIdentifier: "WorkManagementTabBarController") as! WorkManagementTabBarController
        }
    }
    
    struct workUpdate {
        static let workUpdate = UIStoryboard(name: "WorkUpdate", bundle: nil)
        
        static func workManagementUpdateViewController() -> WorkManagementUpdateViewController {
            return workUpdate.instantiateViewController(withIdentifier: "WorkManagementUpdateViewController") as! WorkManagementUpdateViewController
        }
        
        static func mangXongMapViewController() -> MangXongMapViewController {
            return workUpdate.instantiateViewController(withIdentifier: "MangXongMapViewController") as! MangXongMapViewController
        }
        
        static func chooseCotBeViewController() -> ChooseCotBeViewController {
            return workUpdate.instantiateViewController(withIdentifier: "ChooseCotBeViewController") as! ChooseCotBeViewController
        }
        
        static func workmanagamentListOfSuppliesViewController() -> WorkmanagamentListOfSuppliesViewController {
            return workUpdate.instantiateViewController(withIdentifier: "WorkmanagamentListOfSuppliesViewController") as! WorkmanagamentListOfSuppliesViewController
        }

        static func barCodeScannerViewController() -> BarCodeScannerViewController {
            return workUpdate.instantiateViewController(withIdentifier: "BarCodeScannerViewController") as! BarCodeScannerViewController
        }
        
        static func materialInformationViewController() -> MaterialInformationViewController {
            return workUpdate.instantiateViewController(withIdentifier: "MaterialInformationViewController") as! MaterialInformationViewController
        }
    }
	
	// MARK: - Station In Out
	struct stationInOut {
		static let stationInOut = UIStoryboard(name: "StationInOut", bundle: nil)
		
		static func stationNavigationController() -> BaseNavigationController {
			return stationInOut.instantiateViewController(withIdentifier: "StationNavigationController") as! BaseNavigationController
		}
        
		static func stationInOutInfoViewController() -> StationInOutInfoViewController {
			return stationInOut.instantiateViewController(withIdentifier: "StationInOutInfoViewController") as! StationInOutInfoViewController
		}
		
		static func registerInOutStationVC() -> RegisterComeInStationVC {
			return stationInOut.instantiateViewController(withIdentifier: "RegisterComeInStationVC") as! RegisterComeInStationVC
		}
		
		static func locationStationVC() -> LocationStationVC {
			return stationInOut.instantiateViewController(withIdentifier: "LocationStationVC") as! LocationStationVC
		}
		
		static func detailStationVC() -> DetailStationViewController {
			return stationInOut.instantiateViewController(withIdentifier: "DetailStationViewController") as! DetailStationViewController
		}
		
		static func detailWOStation() -> DetailWOStationVC{
			return stationInOut.instantiateViewController(withIdentifier: "DetailWOStationVC") as! DetailWOStationVC
		}
	}
	
    struct newsInfo {
        static let newsInfo = UIStoryboard(name: "NewsInfo", bundle: nil)
        static func newsInfoNavigationController() -> BaseNavigationController {
            return newsInfo.instantiateViewController(withIdentifier: "NewsInfoNavigationController") as! BaseNavigationController
        }
        static func newsInfoViewController() -> NewsInfoVC {
            return newsInfo.instantiateViewController(withIdentifier: "NewsInfoVC") as! NewsInfoVC
        }
        
        static func newsInfoDetailViewController() -> NewsInfoDetailVC
        {
            return newsInfo.instantiateViewController(withIdentifier: "NewsInfoDetailVC") as! NewsInfoDetailVC
        }
    }
	
	//MARK: Utilities
    struct createJobs {
        static let utilityCreateJobs = UIStoryboard(name: "CreateJobs", bundle: nil)
        
        static func rootUtilityCreateJobsNav() -> BaseNavigationController{
            return utilityCreateJobs.instantiateViewController(withIdentifier: "UtilityCreateJobsNav") as! BaseNavigationController
        }
        
        static func createJobsVC() -> CreateJobsVC {
            return utilityCreateJobs.instantiateViewController(withIdentifier: "CreateJobsVC") as! CreateJobsVC
        }
    }
    
    struct checkVersion {
        
        static let utilityCheckVersion = UIStoryboard(name: "CheckVersion", bundle: nil)
        static func rootCheckVersionNavigation() -> BaseNavigationController{
            return utilityCheckVersion.instantiateViewController(withIdentifier: "CheckVersionNavigation") as! BaseNavigationController
        }
        static func checkVersionVC() -> CheckVersionViewController {
            return utilityCheckVersion.instantiateViewController(withIdentifier: "CheckVersionViewController") as! CheckVersionViewController
        }
    }
	struct utilitySearchKTTS{
		static let utilitySearchKTTS = UIStoryboard(name: "UtilitySearchKTTS", bundle: nil)
		
		static func utitlitySearchKTTSNavigation() -> BaseNavigationController{
			return utilitySearchKTTS.instantiateViewController(withIdentifier: "UtilitiSearchKTTSNAV") as! BaseNavigationController
		}
		
		static func detailKTTSInfoVC() -> DetailKTTSViewController{
			return utilitySearchKTTS.instantiateViewController(withIdentifier: "DetailKTTSViewController") as! DetailKTTSViewController
		}
	}
    
    struct checklistCoDien
    {
        static let checkListCoDien = UIStoryboard(name: "CheckListCoDien", bundle: nil)
        
        static func checkListCoDienNavigation() -> BaseNavigationController {
            return checkListCoDien.instantiateViewController(withIdentifier: "CheckListCoDienNavigation") as! BaseNavigationController
        }
        static func checkListCoDienVC() -> CheckListCoDienVC {
            return checkListCoDien.instantiateViewController(withIdentifier: "CheckListCoDienVC") as! CheckListCoDienVC
        }
        
        static func updateCheckListCoDien() -> UpdateCheckListCoDien
        {
            return checkListCoDien.instantiateViewController(withIdentifier: "UpdateCheckListCoDien") as! UpdateCheckListCoDien
        }
    }
    struct resourses {
        static let resourse = UIStoryboard(name: "Resourses", bundle: nil)
        static func resourseInfoNavigationController() -> BaseNavigationController {
            return resourse.instantiateViewController(withIdentifier: "NhapThongTinCoDien2Nav") as! BaseNavigationController
        }
        static func nhapThongTinCoDien2VC() -> NhapThongTinCoDien2VC {
            return resourse.instantiateViewController(withIdentifier: "NhapThongTinCoDien2VC") as! NhapThongTinCoDien2VC
        }
        
        static func nhapThongTinCoDien2DetailVC() -> NhapThongTinCoDien2DetailVC
        {
            return resourse.instantiateViewController(withIdentifier: "NhapThongTinCoDien2DetailVC") as! NhapThongTinCoDien2DetailVC
        }
        
        static func danhMucLuoiDienVC() -> DanhMucLuoiDienVC
        {
            return resourse.instantiateViewController(withIdentifier: "DanhMucLuoiDienVC") as! DanhMucLuoiDienVC
        }
        
        static func themMoiLuoiDienVC() -> ThemMoiLuoiDienVC
        {
            return resourse.instantiateViewController(withIdentifier: "ThemMoiLuoiDienVC") as! ThemMoiLuoiDienVC
        }
        
        
        
        
        static func navTraCuu() -> BaseNavigationController {
            return resourse.instantiateViewController(withIdentifier: "TraCuuTaiNguyenDVCDNav") as! BaseNavigationController
        }
        
        static func traCuuTaiNguyenDVCD_VC() -> TraCuuTaiNguyenDVCD_VC
        {
            return resourse.instantiateViewController(withIdentifier: "TraCuuTaiNguyenDVCD_VC") as! TraCuuTaiNguyenDVCD_VC
        }
        
        static func traCuuTaiNguyenDVCDDetail_VC() -> TraCuuTaiNguyenDVCDDetail_VC
        {
            return resourse.instantiateViewController(withIdentifier: "TraCuuTaiNguyenDVCDDetail_VC") as! TraCuuTaiNguyenDVCDDetail_VC
        }
        
        
        static func navTraCuuThongTinNhaTram() -> BaseNavigationController
        {
            return resourse.instantiateViewController(withIdentifier: "TraCuuThongTinNhaTramNav") as! BaseNavigationController
        }
        
        static func traCuuThongTinNhaTramVC() -> TraCuuThongTinNhaTramVC
        {
            return resourse.instantiateViewController(withIdentifier: "TraCuuThongTinNhaTramVC") as! TraCuuThongTinNhaTramVC
        }
        
        static func traCuuThongTinNhaTramDetailVC() -> TraCuuThongTinNhaTramDetailVC
        {
            return resourse.instantiateViewController(withIdentifier: "TraCuuThongTinNhaTramDetailVC") as! TraCuuThongTinNhaTramDetailVC
        }

    }
    
    struct checklistBaoDuongNhaTram {
        static let checkListBaoDuongNhaTram = UIStoryboard(name: "CheckListBaoDuongNhaTram", bundle: nil)
        
        static func checkListBaoDuongNhaTramNavigation() -> BaseNavigationController {
            return checkListBaoDuongNhaTram.instantiateViewController(withIdentifier: "CheckListBaoDuongNhaTramNavigation") as! BaseNavigationController
        }
        static func checkListBaoDuongNhaTramViewController() -> CheckListBaoDuongNhaTramViewController {
            return checkListBaoDuongNhaTram.instantiateViewController(withIdentifier: "CheckListBaoDuongNhaTramViewController") as! CheckListBaoDuongNhaTramViewController
        }
        
        static func updateAnhDauViecBaoDuongNhaTramViewController() -> UpdateAnhDauViecBaoDuongNhaTramViewController
        {
            return checkListBaoDuongNhaTram.instantiateViewController(withIdentifier: "UpdateAnhDauViecBaoDuongNhaTramViewController") as! UpdateAnhDauViecBaoDuongNhaTramViewController
        }
        
        static func xuLyCVPhaiKhacPhucTrongTramViewController() -> XuLyCVPhaiKhacPhucTrongTramViewController
        {
            return checkListBaoDuongNhaTram.instantiateViewController(withIdentifier: "XuLyCVPhaiKhacPhucTrongTramViewController") as! XuLyCVPhaiKhacPhucTrongTramViewController
        }
        
    }
    
    struct manageWorkIncurred
    {
        static let manageWorkIncurred = UIStoryboard(name: "ManageWorkIncurred", bundle: nil)
        
        static func manageWorkIncurredNavigation() -> BaseNavigationController {
            return manageWorkIncurred.instantiateViewController(withIdentifier: "ManageWorkIncurredNavigation") as! BaseNavigationController
        }
        static func offerListVC() -> OfferListViewController {
            return manageWorkIncurred.instantiateViewController(withIdentifier: "OfferListVC") as! OfferListViewController
        }
        
        static func updateOfferVC() -> UpdateOfferViewController {
            return manageWorkIncurred.instantiateViewController(withIdentifier: "UpdateOfferVC") as! UpdateOfferViewController
        }
        
        static func listItemsIncurredVC() -> ListItemsIncurredViewController {
            return manageWorkIncurred.instantiateViewController(withIdentifier: "ListItemsIncurredVC") as! ListItemsIncurredViewController
        }
        
        static func attachWorkIncurredFileVC() -> AttachWorkIncurredFileViewController {
            return manageWorkIncurred.instantiateViewController(withIdentifier: "AttachWorkIncurredFileVC") as! AttachWorkIncurredFileViewController
        }
    }
	
	//MARK: Utility - Manage Viba
	struct utilityManageViba{
		static let utilityManageViba = UIStoryboard(name: "UtilityViba", bundle: nil)
		
		static func rootUtilityVibaNav() -> BaseNavigationController{
			return utilityManageViba.instantiateViewController(withIdentifier: "UtilityVibaNav") as! BaseNavigationController
		}
		
		static func manageVibaVC() -> ManageVibaVC{
			return utilityManageViba.instantiateViewController(withIdentifier: "ManageVibaVC") as! ManageVibaVC
		}
	}
	
	//MARK: WO - Notify lost/break/unuse
	struct woNotify{
		static let woNotify = UIStoryboard(name: "WO_Notify", bundle: nil)
		static func rootWoNotifyNav() -> BaseNavigationController{
			return woNotify.instantiateViewController(withIdentifier: "WO_NotifyNav") as! BaseNavigationController
		}
        
        static func listStationVC() -> ListStationVC{
            return woNotify.instantiateViewController(withIdentifier: "ListStationVC") as! ListStationVC
        }
        static func listWarehouseVC() -> ListWarehouseVC{
            return woNotify.instantiateViewController(withIdentifier: "ListWarehouseVC") as! ListWarehouseVC
        }
        static func wo_AssetStationVC() -> WO_AssetStationVC{
            return woNotify.instantiateViewController(withIdentifier: "WO_AssetStationVC") as! WO_AssetStationVC
        }
	}
    struct utility_TestAndSurvey
    {
        static let utility_TestAndSurveyStoryBoard = UIStoryboard(name: "UtilityTestAndSurvey", bundle: nil)
        static func rootTestAndSurveyNav() -> BaseNavigationController{
            return utility_TestAndSurveyStoryBoard.instantiateViewController(withIdentifier: "Utility_TestAndSurveyNav") as! BaseNavigationController
        }
        
        static func testAndSurvey() -> Utility_TestAndSurvey{
            return utility_TestAndSurveyStoryBoard.instantiateViewController(withIdentifier: "Utility_TestAndSurvey") as! Utility_TestAndSurvey
        }
        static func testAndSurveyDetail() -> Utility_TestAndSurveyDetail{
            return utility_TestAndSurveyStoryBoard.instantiateViewController(withIdentifier: "Utility_TestAndSurveyDetail") as! Utility_TestAndSurveyDetail
        }
    }
    struct wo_CombineElectromechanical
    {
        static let wo_CombineElectromechanical = UIStoryboard(name: "WO_CombineElectromechanical", bundle: nil)
        static func rootElectromechanical() -> BaseNavigationController{
            return wo_CombineElectromechanical.instantiateViewController(withIdentifier: "WO_CombineElectromechanicalNav") as! BaseNavigationController
        }
        
        static func deviceInfo() -> WO_DeviceInfo{
            return wo_CombineElectromechanical.instantiateViewController(withIdentifier: "WO_DeviceInfo") as! WO_DeviceInfo
        }
        static func editDevice() -> WO_InsertEdit_DeviceDetailInfo{
            return wo_CombineElectromechanical.instantiateViewController(withIdentifier: "WO_InsertEdit_DeviceDetailInfo") as! WO_InsertEdit_DeviceDetailInfo
        }
        static func listElements() -> WO_ListElements{
            return wo_CombineElectromechanical.instantiateViewController(withIdentifier: "WO_ListElements") as! WO_ListElements
        }
    }
}




