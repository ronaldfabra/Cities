//
//  Network.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import Foundation

class Network: NetworkProtocol {
    static let shared = Network()

    func request<T: Decodable>(endPoint: EndPointProtocol, type _: T.Type) async throws -> T {
        do {
            guard let urlCompponent = NSURLComponents(string: endPoint.urlString) else {
                throw NetworkErrorType.generalError
            }
            var items = [URLQueryItem]()
            for queryParam in endPoint.parameters {
                items.append(URLQueryItem(name: queryParam.key, value: "\(queryParam.value)"))
            }
            items = items.filter{!$0.name.isEmpty}
            if !items.isEmpty {
                urlCompponent.queryItems = items
            }
            guard let url = urlCompponent.url else {
                throw NetworkErrorType.invalidURL
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = endPoint.method
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == ResponseStatusType.success.rawValue else {
                guard var errorModel = try? decoder.decode(ApiErrorDto.self, from: data) else {
                    if (response as? HTTPURLResponse)?.statusCode == ResponseStatusType.notFound.rawValue {
                        throw NetworkErrorType.invalidParams
                    } else {
                        throw NetworkErrorType.generalError
                    }
                }
                errorModel.code = (response as? HTTPURLResponse)?.statusCode
                throw errorModel
            }
            do {
                let model = try decoder.decode(T.self, from: data)
                return model
            } catch {
                throw NetworkErrorType.invalidData
            }
        } catch let error as ApiErrorDto {
            throw NetworkErrorType.error(from: error)
        } catch let error as NetworkErrorType {
            throw error
        } catch {
            if (error as NSError).code < .zero {
                throw NetworkErrorType.internetConnection
            }
            throw NetworkErrorType.unkown(error)
        }
    }
}
