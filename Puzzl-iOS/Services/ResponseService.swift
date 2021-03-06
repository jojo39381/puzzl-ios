//
//  ResponseService.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/29/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import Foundation
import Alamofire

class ResponseService {
    static let shared = ResponseService()
    
    lazy var networkService: NetworkService = {
        return NetworkService.shared
    }()
    
    let BASE_URL = NetworkService.shared.BASE_URL
}

// MARK: - Requests
extension ResponseService {
    public func getUserInfo(completion:@escaping ((Response<GetUserModel>)->())) {
        var url = "\(BASE_URL)/getUserInfo"
        let parameters: [String : String] = ["companyID" : "\(Puzzl.companyID)"]
        
        do {
            url = try networkService.createQuery(to: url, parameters: parameters)
            networkService.handleRequest(networkService.createRequest(url, method: .get, encoding: JSONEncoding.default),
                                         completion: completion)
        } catch {
        
            print(error.localizedDescription)
        }
    }
    
    public func getEmployeeInfo(completion:@escaping ((Response<GetEmployeeModel>)->())) {
        
        var url = "\(BASE_URL)/getWorkerInfo"
        let parameters: [String : String] =    ["companyID" : "\(Puzzl.companyID)",
                                                "employeeID" : "\(Puzzl.employeeID)"]
        
        do {
            url = try networkService.createQuery(to: url, parameters: parameters)
            networkService.handleRequest(networkService.createRequest(url, method: .get, encoding: JSONEncoding.default),
                                         completion: completion)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func configureVeriff(firstName: String, lastName: String, timestamp: String, document: [String:Any], completion:@escaping ((Response<VeriffAnswer>)->())) {
        let parameters = ["verification" : [ "person" : ["firstName" : firstName,
                                                         "lastName" : lastName],
                                             "document" : document,
                                             "lang" : "en",
                                             "timestamp" : timestamp] ]
        let headers: HTTPHeaders = ["X-AUTH-CLIENT": "d82d7c3d-9b78-4fed-b374-5f6cfbc20a16", "Content-Type": "application/json"]
        networkService.handleRequest(networkService.createRequest("https://api.veriff.me/v1/sessions/",
                                                                  method: .post,
                                                                  parameters: parameters,
                                                                  encoding: JSONEncoding.default,
                                                                  headers: headers),
                                     completion: completion,
                                     isBaseResponse: false)
    }
    
    public func signW2(parameters: [String: Any], completion:@escaping ((Response<HellosignModel>)->())) {
        let url = "\(BASE_URL)/signW2"
        
        networkService.handleRequest(networkService.createRequest(url, method: .post, parameters: parameters, encoding: JSONEncoding.default),
                                     completion: completion,
                                     isBaseResponse: false)
    }
    
    public func submitWorkerProfileInfo(){
        
        
        let url = "\(BASE_URL)/submitWorkerProfileInfo"
        Alamofire.upload(multipartFormData: { (formData) in
            formData.append(PassingData.shared.signW2Model.companyID.data(using: .utf8) ?? Data(), withName: "companyID")
            formData.append(Puzzl.employeeID.data(using: .utf8) ?? Data(), withName: "employeeID")
            formData.append(PassingData.shared.signW2Model.firstName.data(using: .utf8) ?? Data(), withName: "first_name")
            if let middleInitial = PassingData.shared.signW2Model.middlInitial {
                formData.append(middleInitial.data(using: .utf8) ?? Data(), withName: "middle_initial")
            }
            formData.append(PassingData.shared.signW2Model.lastName.data(using: .utf8) ?? Data(), withName: "last_name")
            if let dob = PassingData.shared.dob {
                formData.append(dob.data(using: .utf8) ?? Data(), withName: "dob")
            }
            formData.append(PassingData.shared.signW2Model.title.data(using: .utf8) ?? Data(), withName: "title")
            formData.append(PassingData.shared.signW2Model.address.data(using: .utf8) ?? Data(), withName: "address")
            formData.append(PassingData.shared.signW2Model.city.data(using: .utf8) ?? Data(), withName: "city")
            formData.append(PassingData.shared.signW2Model.state.data(using: .utf8) ?? Data(), withName: "state")
            formData.append(PassingData.shared.signW2Model.ssn.data(using: .utf8) ?? Data(), withName: "ssn")
             formData.append(PassingData.shared.signW2Model.phoneNumber.data(using: .utf8) ?? Data(), withName: "phone_number")
            
            formData.append(PassingData.shared.signW2Model.zip.data(using: .utf8) ?? Data (), withName: "zip")
            
            if let last4 = PassingData.shared.last4 {
                formData.append(last4.data(using: .utf8) ?? Data(), withName: "last4_ssn")
            }
        
            
            formData.append(PassingData.shared.signW2Model.email.data(using: .utf8) ?? Data(), withName: "email")
            formData.append(PassingData.shared.password.data(using: .utf8) ?? Data(), withName: "password")
        }, usingThreshold: 1, to: url, method: .post, headers: NetworkService.getHeaders()) { (status) in
            switch status {
            case .success(let result, _, _):
                result.responseJSON(completionHandler: { (response) in
                    print(response.result.value ?? "No value")
                    print("Sucessfully submitted Worker Profile Info")
                    //completion(response.result)
                })
            case .failure(_):
                print("Failed to submit Worker Profile Info")
                print("error")
                print(status)
            }
        }
    }
    
    public func submitWorkerVerification(){
        
        
        let url = "\(BASE_URL)/submitWorkerVerification"
        Alamofire.upload(multipartFormData: { (formData) in
            formData.append(PassingData.shared.signW2Model.companyID.data(using: .utf8) ?? Data(), withName: "companyID")
            formData.append(Puzzl.employeeID.data(using: .utf8) ?? Data(), withName: "employeeID")
            formData.append(PassingData.shared.veriffId.data(using: .utf8) ?? Data(), withName: "veriff_id")
//            if let image = PassingData.shared.driversPhoto {
//                formData.append(image.jpegData(compressionQuality: 0.96) ?? Data(), withName: "ss_card", fileName: "screenshort\(UUID().uuidString).jpg", mimeType: "image/jpeg")
//            }
        }, usingThreshold: 1, to: url, method: .post, headers: NetworkService.getHeaders()) { (status) in
            switch status {
            case .success(let result, _, _):
                result.responseJSON(completionHandler: { (response) in
                    print(response.result.value ?? "No value")
                    print("Successfully sent employee verification")
                    //completion(response.result)
                })
            case .failure(_):
                print("error")
                print(status)
            }
        }
        
    }
    public func submitWorkerPaperwork(){
        let url = "\(BASE_URL)/submitWorkerPaperwork"
                
        Alamofire.upload(multipartFormData: { (formData) in
            formData.append(PassingData.shared.signW2Model.companyID.data(using: .utf8) ?? Data(), withName: "companyID")
            formData.append(Puzzl.employeeID.data(using: .utf8) ?? Data(), withName: "employeeID")
            formData.append(PassingData.shared.signW2Model.email.data(using: .utf8) ?? Data(), withName: "email")
            if let employeeSigId = PassingData.shared.helloSignModel?.employee_sigId {
                formData.append(employeeSigId.data(using: .utf8) ?? Data(), withName: "employee_sigId")
            }
            if let companySigId = PassingData.shared.helloSignModel?.company_sigId {
                formData.append(companySigId.data(using: .utf8) ?? Data(), withName: "company_sigId")
            }
            if let signatureRequestId = PassingData.shared.helloSignModel?.signature_request_id {
                formData.append(signatureRequestId.data(using: .utf8) ?? Data(), withName: "signature_request_id")
            }
        }, usingThreshold: 1, to: url, method: .post, headers: NetworkService.getHeaders()) { (status) in
            switch status {
            case .success(let result, _, _):
                result.responseJSON(completionHandler: { (response) in
                    print(response.result.value ?? "No value")
                    print("Successfully submitted worker paperwork")
                    //completion(response.result)
                })
            case .failure(_):
                print("error")
                print(status)
            }
        }
    }
    
    public func generateSSCardPutURL(completion:@escaping ((Response<SSCardURL>)->())) {
    var url = "https://api.joinpuzzl.com/generate-sscard-put-url"
//    print(PassingData.shared.signW2Model.email)
    let parameters: [String : String] =    ["Key" : "\(PassingData.shared.signW2Model.email)-sscard",
    "ContentType" : "image/jpeg"]
    
    do {
        url = try networkService.createQuery(to: url, parameters: parameters)
        networkService.handleRequest(networkService.createRequest(url, method: .get, encoding: JSONEncoding.default, headers: NetworkService.getUploadHeaders()),
                                     completion: completion)
    } catch {
    
        print(error.localizedDescription)
    }
        
    }
    
    public func uploadSSCard(){
        let image:UIImage = PassingData.shared.driversPhoto!
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
          let err = NSError(domain: "pl.appbeat", code: 9_999, userInfo: ["Data error": "Was not able to prepare image from data."])
         print(err)
          return
        }

//        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        let url = "\(PassingData.shared.SSCardURL!.putURL)"
        let headers = [
            "Content-Type": "image/jpeg"
        ]
//        let parameters: [String : String] =    ["Key" : "\(PassingData.shared.signW2Model.email)-sscard", "Content-Type" : "image/jpeg"]
        
        Alamofire.upload(imageData, to: url, method: .put, headers: headers)
            .responseData {
                response in
                guard let httpResponse = response.response else {
                     print("Something went wrong uploading")
                     return
                }

                if let publicUrl = url.components(separatedBy: "?").first {
                     print("Successfully uploaded SS Card")
                }
        }
        
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
//            //Any Post Params if you have.
//            for (key, value) in parameters {
//                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//            }
//        }, usingThreshold: 1, to:url, method: .put, headers: NetworkService.getUploadHeaders()) //uploadUrlStr: upload url in your case
//        { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.uploadProgress(closure: { (progress) in
//                    print("Uploading")
//                    print(CGFloat(progress.fractionCompleted * 100))
//                })
//
//                upload.responseString { response in
//                    print("Upload Finished")
//                    print(response)
//                    guard let resultValue = response.result.value else {
//                        NSLog("Result value in response is nil")
//                        return
//                    }
//
//                }
//
//            case .failure(let encodingError):
//                print(encodingError.localizedDescription)
//            }
        }

//        Alamofire.upload(multipartFormData: { (formData) in
//            formData.append(_: InputStream(data: imageData), withLength: UInt64(imageData.count), headers:  ["Content-Disposition": "form-data; name=\"file\"",
//               "ContentType" : "image/jpeg"])
//        }, to: url, method: .put, headers: NetworkService.getUploadHeaders()){
//            (status) in
//                switch status {
//                case .success(let result, _, _):
//                    result.responseJSON(completionHandler: { (response) in
//                        print(response.result ?? "No value")
//                        //completion(response.result)
//                    })
//                case .failure(_):
//                    print("error")
//                    print(status)
//                }
//            }
        
        

        
    
    public func onboardEmployee() {
        let url = "\(BASE_URL)/onboardWorker"
        
        Alamofire.upload(multipartFormData: { (formData) in
            formData.append(PassingData.shared.signW2Model.companyID.data(using: .utf8) ?? Data(), withName: "companyID")
            formData.append(Puzzl.employeeID.data(using: .utf8) ?? Data(), withName: "id")
            formData.append(PassingData.shared.signW2Model.firstName.data(using: .utf8) ?? Data(), withName: "first_name")
            if let middleInitial = PassingData.shared.signW2Model.middlInitial {
                formData.append(middleInitial.data(using: .utf8) ?? Data(), withName: "middle_initial")
            }
            formData.append(PassingData.shared.signW2Model.lastName.data(using: .utf8) ?? Data(), withName: "last_name")
            if let dob = PassingData.shared.dob {
                formData.append(dob.data(using: .utf8) ?? Data(), withName: "dob")
            }
            formData.append(PassingData.shared.signW2Model.address.data(using: .utf8) ?? Data(), withName: "address")
            formData.append(PassingData.shared.signW2Model.city.data(using: .utf8) ?? Data(), withName: "city")
            formData.append(PassingData.shared.signW2Model.state.data(using: .utf8) ?? Data(), withName: "state")
            formData.append(PassingData.shared.signW2Model.ssn.data(using: .utf8) ?? Data(), withName: "ssn")
//            if let last4 = PassingData.shared.last4 {
//                formData.append(last4.data(using: .utf8) ?? Data(), withName: "last4_ssn")
//            }
            formData.append(PassingData.shared.signW2Model.email.data(using: .utf8) ?? Data(), withName: "email")
            formData.append(PassingData.shared.signW2Model.phoneNumber.data(using: .utf8) ?? Data(), withName: "phone_number")
            formData.append(PassingData.shared.password.data(using: .utf8) ?? Data(), withName: "password")
//            formData.append("\(PassingData.shared.signW2Model.defaultWage)".data(using: .utf8) ?? Data(), withName: "default_wage")
//            formData.append("\(PassingData.shared.signW2Model.defaultOtWage)".data(using: .utf8) ?? Data(), withName: "default_ot_wage")
//            formData.append(PassingData.shared.signW2Model.createdAt.data(using: .utf8) ?? Data(), withName: "createdAt")
            if let employeeSigId = PassingData.shared.helloSignModel?.employee_sigId {
                formData.append(employeeSigId.data(using: .utf8) ?? Data(), withName: "employee_sigId")
            }
            if let companySigId = PassingData.shared.helloSignModel?.company_sigId {
                formData.append(companySigId.data(using: .utf8) ?? Data(), withName: "company_sigId")
            }
            if let signatureRequestId = PassingData.shared.helloSignModel?.signature_request_id {
                formData.append(signatureRequestId.data(using: .utf8) ?? Data(), withName: "signature_request_id")
            }
            formData.append(PassingData.shared.veriffId.data(using: .utf8) ?? Data(), withName: "veriff_id")
//            if let image = PassingData.shared.driversPhoto {
//                formData.append(image.jpegData(compressionQuality: 0.96) ?? Data(), withName: "ss_card", fileName: "screenshort\(UUID().uuidString).jpg", mimeType: "image/jpeg")
//            }
        }, usingThreshold: 1, to: url, method: .post, headers: NetworkService.getHeaders()) { (status) in
            switch status {
            case .success(let result, _, _):
                result.responseJSON(completionHandler: { (response) in
                    print(response.result.value ?? "No value")
                    //completion(response.result)
                })
            case .failure(_):
                print("error")
                print(status)
            }
        }
    }
}

