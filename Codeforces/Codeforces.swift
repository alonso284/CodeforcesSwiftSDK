//
//  Codeforces.swift
//  Codeforces
//
//  Created by Alonso Huerta on 23/04/26.
//
//  Main client for the Codeforces API.
//  Supports both public (unauthenticated) and authorized (API key) requests.
//
//  Authorization:
//    Codeforces uses HMAC-style signing with SHA-512.
//    Signature = SHA512( rand/methodName?sortedParams#apiSecret )
//    The request URL includes apiKey, time, and apiSig query parameters.
//
//  Usage:
//    let client = CodeforcesAPI()                           // public access
//    let client = CodeforcesAPI(key: "...", secret: "...")   // authorized access
//

import Foundation
import CryptoKit

// MARK: - API Response Wrapper

/// Wrapper for all Codeforces API responses.
struct CFResponse<T: Decodable>: Decodable {
    let status: String
    let result: T?
    let comment: String?
}

// MARK: - API Errors

/// Errors thrown by the Codeforces API client.
public enum CFError: Error, LocalizedError {
    /// The API returned a `FAILED` status with a message.
    case apiError(String)
    /// A network or decoding error occurred.
    case networkError(Error)
    /// Authorization credentials are missing for a method that requires them.
    case unauthorized
    /// The response could not be decoded.
    case decodingError(Error)

    public var errorDescription: String? {
        switch self {
        case .apiError(let message): return "Codeforces API error: \(message)"
        case .networkError(let error): return "Network error: \(error.localizedDescription)"
        case .unauthorized: return "API key and secret are required for this method."
        case .decodingError(let error): return "Decoding error: \(error.localizedDescription)"
        }
    }
}

// MARK: - Client

/// A client for the Codeforces API.
///
/// Provides async methods for all Codeforces API endpoints.
/// Initialize with API key and secret for endpoints that require authorization.
public final class CodeforcesAPI: @unchecked Sendable {
    /// Base URL for all API requests.
    public static let baseURL = "https://codeforces.com/api"

    private let session: URLSession
    private let apiKey: String?
    private let apiSecret: String?

    /// Creates a new Codeforces API client.
    ///
    /// - Parameters:
    ///   - key: Your Codeforces API key. Required for authorized endpoints.
    ///   - secret: Your Codeforces API secret. Required for authorized endpoints.
    ///   - session: A custom URLSession (defaults to `.shared`).
    public init(key: String? = nil, secret: String? = nil, session: URLSession = .shared) {
        self.apiKey = key
        self.apiSecret = secret
        self.session = session
    }

    /// Whether this client has authorization credentials.
    public var isAuthorized: Bool {
        apiKey != nil && apiSecret != nil
    }

    // MARK: - Internal Request Execution

    /// Executes an API request and decodes the result.
    ///
    /// - Parameters:
    ///   - method: The API method name (e.g., "user.info").
    ///   - params: Query parameters for the request.
    ///   - authorized: Whether to sign the request with API credentials.
    ///                 When `true` and no credentials are set, throws `CFError.unauthorized`.
    ///                 When `false` but credentials are available, they are still used
    ///                 (some endpoints accept optional auth for extra access).
    /// - Returns: The decoded result of type `T`.
    internal func request<T: Decodable>(
        method: String,
        params: [String: String] = [:],
        authorized: Bool = false
    ) async throws -> T {
        var allParams = params

        let shouldSign = authorized || isAuthorized

        if authorized && !isAuthorized {
            throw CFError.unauthorized
        }

        if shouldSign, let key = apiKey, let secret = apiSecret {

            let time = String(Int(Date().timeIntervalSince1970))
            let rand = String(format: "%06d", Int.random(in: 100000...999999))

            allParams["apiKey"] = key
            allParams["time"] = time

            // Sort parameters alphabetically for signature
            let sortedParams = allParams.sorted { $0.key < $1.key }
            let paramString = sortedParams.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            let sigPayload = "\(rand)/\(method)?\(paramString)#\(secret)"

            let hash = SHA512.hash(data: Data(sigPayload.utf8))
            let hashHex = hash.map { String(format: "%02x", $0) }.joined()

            allParams["apiSig"] = "\(rand)\(hashHex)"
        }

        let queryItems = allParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        var components = URLComponents(string: "\(Self.baseURL)/\(method)")!
        components.queryItems = queryItems

        let url = components.url!
        let (data, _) = try await session.data(from: url)

        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(CFResponse<T>.self, from: data)
            if response.status == "OK", let result = response.result {
                return result
            } else {
                throw CFError.apiError(response.comment ?? "Unknown error")
            }
        } catch let error as CFError {
            throw error
        } catch {
            throw CFError.decodingError(error)
        }
    }
}
