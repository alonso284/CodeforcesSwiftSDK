//
//  Submission.swift
//  Codeforces
//
//  Codeforces API Object: Represents a submission to a problem.
//  https://codeforces.com/apiHelp/objects#Submission
//

import Foundation

/// The verdict of a submission.
public enum CFVerdict: String, Codable, Sendable {
    case failed = "FAILED"
    case ok = "OK"
    case partial = "PARTIAL"
    case compilationError = "COMPILATION_ERROR"
    case runtimeError = "RUNTIME_ERROR"
    case wrongAnswer = "WRONG_ANSWER"
    case presentationError = "PRESENTATION_ERROR"
    case timeLimitExceeded = "TIME_LIMIT_EXCEEDED"
    case memoryLimitExceeded = "MEMORY_LIMIT_EXCEEDED"
    case idlenessLimitExceeded = "IDLENESS_LIMIT_EXCEEDED"
    case securityViolated = "SECURITY_VIOLATED"
    case crashed = "CRASHED"
    case inputPreparationCrashed = "INPUT_PREPARATION_CRASHED"
    case challenged = "CHALLENGED"
    case skipped = "SKIPPED"
    case testing = "TESTING"
    case rejected = "REJECTED"
}

/// The testset used for judging a submission.
public enum CFTestset: String, Codable, Sendable {
    case samples = "SAMPLES"
    case pretests = "PRETESTS"
    case tests = "TESTS"
    case challenges = "CHALLENGES"
    case tests1 = "TESTS1"
    case tests2 = "TESTS2"
    case tests3 = "TESTS3"
    case tests4 = "TESTS4"
    case tests5 = "TESTS5"
    case tests6 = "TESTS6"
    case tests7 = "TESTS7"
    case tests8 = "TESTS8"
    case tests9 = "TESTS9"
    case tests10 = "TESTS10"
}

/// Represents a submission to a Codeforces problem.
public struct CFSubmission: Codable, Equatable, Sendable {
    /// Submission ID.
    public let id: Int
    /// Contest ID the submission belongs to.
    public let contestId: Int?
    /// UNIX timestamp of the submission.
    public let creationTimeSeconds: Int
    /// Seconds relative to the contest start.
    public let relativeTimeSeconds: Int
    /// The problem the submission is for.
    public let problem: CFProblem
    /// The author (party) of the submission.
    public let author: CFParty
    /// Programming language used.
    public let programmingLanguage: String
    /// Verdict of the submission. May be absent if still testing.
    public let verdict: CFVerdict?
    /// Testset used for judging.
    public let testset: CFTestset
    /// Number of tests passed.
    public let passedTestCount: Int
    /// Maximum time consumed by any test in milliseconds.
    public let timeConsumedMillis: Int
    /// Maximum memory consumed by any test in bytes.
    public let memoryConsumedBytes: Int
    /// Points scored (for IOI-style contests).
    public let points: Double?
}
