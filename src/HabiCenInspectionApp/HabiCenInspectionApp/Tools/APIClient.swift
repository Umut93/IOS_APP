//
//  APIClient.swift
//  emmaz_syn
//
//  Created by Mikkel Jensen on 04/03/2022.
//

import Foundation

struct None: Equatable, Codable {}

final class APIClient {
    static let shared: APIClient = .init()

    private let appContext: AppContext = .shared

    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init() {
        encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601WithFractalSeconds
    }

    private func send<TIn: Encodable, TOut: Decodable>(_ httpMetod: RequestMethod, to url: URL, with payload: TIn) async throws -> TOut {
        var request = URLRequest(url: url)
        request.httpMethod = httpMetod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        await request.setValue(getAuthorizationHeaderValue(), forHTTPHeaderField: "Authorization")

        if !(payload is None) {
            request.httpBody = try encoder.encode(payload)
        }

        if await appContext.authContext.isTokenExpired() {
            await appContext.authContext.login()
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        if let response = response as? HTTPURLResponse, response.statusCode == 401 {
            throw APIErrors.unauthorized(message: "unauthorized")
        }

        if let response = response as? HTTPURLResponse, response.statusCode >= 400 {
            if data.isEmpty {
                throw APIErrors.unexpected(message: "StatusCode: \(response.statusCode)")
            }

            let message = try decoder.decode(String.self, from: data)
            throw APIErrors.unexpected(message: "StatusCode: \(response.statusCode), Message: \(message)")
        }

        return try decoder.decode(TOut.self, from: data)
    }

    func get<TOut: Decodable>(url: URL) async throws -> TOut? {
        return try await send(.get, to: url, with: None())
    }

    func post<TIn: Encodable, TOut: Decodable>(url: URL, payload: TIn) async throws -> TOut? {
        return try await send(.post, to: url, with: payload)
    }

    func post<TOut: Decodable>(url: URL) async throws -> TOut? {
        return try await send(.post, to: url, with: None())
    }

    func put<TIn: Encodable, TOut: Decodable>(url: URL, payload: TIn) async throws -> TOut? {
        return try await send(.put, to: url, with: payload)
    }

    func put<TOut: Decodable>(url: URL) async throws -> TOut? {
        return try await send(.put, to: url, with: None())
    }

    func delete<TIn: Encodable, TOut: Decodable>(url: URL, payload: TIn) async throws -> TOut {
        return try await send(.delete, to: url, with: payload)
    }

    func delete<TOut: Decodable>(url: URL) async throws -> TOut {
        return try await send(.delete, to: url, with: None())
    }

    private func getAuthorizationHeaderValue() async -> String {
        let token = await appContext.authContext.accessToken
        return "Bearer " + token
    }
}

extension APIClient {
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}

extension APIClient {
    static func createURL(endpoint url: String, parameters: [String: String] = [:]) -> URL? {
        #if DEBUG
        let baseURL = "http://172.32.0.144:8080/"
        #else
        let baseURL = "https://habicen-inspection.uniktest.dk/"
        #endif
        var urlComponents = URLComponents(string: baseURL + url)
        if !parameters.isEmpty {
            urlComponents?.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }
        return urlComponents?.url
    }
}
