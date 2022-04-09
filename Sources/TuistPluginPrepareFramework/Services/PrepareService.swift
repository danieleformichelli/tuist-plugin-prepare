import Foundation
import TSCBasic

/// A service that prepares Xcode projects with Tuist.
public final class PrepareService {
    public init() {}

    public func run(
        path: String?,
        targets: [String],
        noOpen: Bool,
        xcframeworks: Bool,
        profile: String?,
        ignoreCache: Bool,
        update: Bool
    ) throws {
        let ignoreCacheArgument = ignoreCache ? ["--no-cache"] : []
        let noOpenArgument = noOpen ? ["--no-open"] : []
        let pathArgument = path.map { ["--path", "\($0)"] } ?? []
        let profileArgument = profile.map { ["--profile", "\($0)"] } ?? []
        let updateArgument = update ? ["--update"] : []
        let xcframeworksArgument = xcframeworks ? ["--xcframeworks"] : []

        try Self.runAndPrint([
            [
                "tuist",
                "fetch"
            ],
            pathArgument,
            updateArgument,
        ].flatMap { $0 })

        if !ignoreCache {
            try Self.runAndPrint([
                [
                    "tuist",
                    "cache",
                    "warm",
                    "--dependencies-only"
                ],
                targets,
                pathArgument,
                profileArgument,
                xcframeworksArgument,
            ].flatMap { $0 })
        }

        try Self.runAndPrint([
            [
                "tuist",
                "generate",
            ],
            targets,
            pathArgument,
            profileArgument,
            xcframeworksArgument,
            ignoreCacheArgument,
            noOpenArgument,
        ].flatMap { $0 })
    }

    private static func runAndPrint(_ arguments: [String]) throws {
        let process = Process(
            arguments: arguments,
            environment: [:],
            outputRedirection: .stream(
                stdout: { FileHandle.standardOutput.write(Data($0)) },
                stderr: { FileHandle.standardError.write(Data($0)) }
            ),
            verbose: false,
            startNewProcessGroup: false
        )

        try process.launch()
        let result = try process.waitUntilExit()

        switch result.exitStatus {
        case .signalled:
            throw result.exitStatus
        case .terminated(let code):
            guard code == 0 else {
                throw result.exitStatus
            }
        }
    }
}

extension ProcessResult.ExitStatus: Error {}
