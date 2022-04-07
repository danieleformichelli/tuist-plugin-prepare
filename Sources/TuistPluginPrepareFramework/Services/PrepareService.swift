import Foundation
import TSCBasic

/// A service that prepares Xcode projects with Tuist.
public final class PrepareService {
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
        let pathArgument = path.map { ["--path \($0)"] } ?? []
        let profileArgument = profile.map { ["--profile \($0)"] } ?? []
        let updateArgument = update ? ["--update"] : []
        let xcframeworksArgument = xcframeworks ? ["--xcframeworks"] : []

        try Self.runAndPrint(
            [
                "tuist",
                "fetch"
            ]
            + pathArgument
            + updateArgument
        )

        if !ignoreCache {
            try Self.runAndPrint(
                [
                    "tuist",
                    "cache",
                    "warm",
                    "--dependencies-only"
                ]
                + targets
                + pathArgument
                + profileArgument
                + xcframeworksArgument
            )
        }

        try Self.runAndPrint(
            [
                "tuist",
                "generate",
            ]
            + targets
            + pathArgument
            + profileArgument
            + xcframeworksArgument
            + ignoreCacheArgument
            + noOpenArgument
        )
    }

    private func runAndPrint(_ arguments: [String]) throws {
        let process = Process(
            arguments: arguments,
            environment: environment,
            outputRedirection: .stream(
                stdout: { FileHandle.standardOutput.write(Data($0)) },
                stderr: { FileHandle.standardError.write(Data($0)) }
            ),
            verbose: false,
            startNewProcessGroup: false
        )

        try process.launch()
        let result = try process.waitUntilExit()
        let output = try result.utf8Output()

        try result.throwIfErrored()
    }
}
