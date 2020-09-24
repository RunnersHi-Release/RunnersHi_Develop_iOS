//
//  LoginService.swift
//  Runners_Hi
//
//  Created by 최영재 on 2020/07/11.
//  Copyright © 2020 김민희. All rights reserved.
//
import Foundation
import Alamofire

struct LoginService {
    static let shared = LoginService()
    
    private func makeLoginParameter(_ id: String, _ password: String) -> Parameters {
        return ["id": id, "password": password]
    }//Request Body에 들어갈 parameter 생성, String으로 받은걸 list로 만들어주는 과정
    
    private func makeUuidParameter(_ uuid: String) -> Parameters {
        return ["uuid" : uuid]
    }
    
    func login(id: String, password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        let dataRequest = Alamofire.request(APIConstants.loginURL, method: .post, parameters: makeLoginParameter(id, password), encoding: JSONEncoding.default, headers: header)
        
        //데이터 통신
        dataRequest.responseData { dataResponse in switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                //guard : dataResponse.response의 값이 존재하면 statusCode = dataResponse.response 선언을 하고, 아니면 그냥 리턴
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.judge(by: statusCode, value)
                completion(networkResult)
            case .failure: completion(.networkFail)
            }
        }
    }
    
    private func judge(by statusCode: Int, _ result: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isUser(by: result)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isUser(by result: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(LoginData.self, from: result) else { return .pathErr }
        //decoder.decode의 값이 존재하면 decodeDAta에 대입하고, 아니면 pathErr 리턴
        
        guard let tokenData = decodedData.result else { return .requestErr(decodedData.message) }
        
        return .success(tokenData.token)
    }
    //uuid CheckIn에 쓰이는 서버 함수
    func uuidCheckIn(uuid: String, completion: @escaping (NetworkResult<Any>) -> Void) {

        let header: HTTPHeaders = ["Content-Type": "application/json"]
        let dataRequest = Alamofire.request(APIConstants.uuidURL, method: .post, parameters: makeUuidParameter(uuid), encoding: JSONEncoding.default, headers: header)

        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success :
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.uuidJudge(by: statusCode, value)
                completion(networkResult)
                print(networkResult)
            case .failure: completion(.networkFail)

            }

        }
    }
    private func uuidJudge(by statusCode: Int, _ result: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isUuid(by: result)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }

    private func isUuid(by result: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(UuidData.self, from: result) else { return .pathErr }
        //decoder.decode의 값이 존재하면 decodeDAta에 대입하고, 아니면 pathErr 리턴
        guard let uuidData = decodedData.data else { return .requestErr(decodedData.message) }
        
        return .success(uuidData)
    }
}
