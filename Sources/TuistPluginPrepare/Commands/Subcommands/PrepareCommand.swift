import ArgumentParser
import TuistPluginPrepareFramework

/// A command to prepare the Xcode project using Tuist.
struct PrepareCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "prepare",
        abstract: "Prepares and opens the Tuist project."
    )

    @Option(
        name: .shortAndLong,
        help: "The path to the directory that contains the definition of the project.",
        completion: .directory
    )
    var path: String?

    @Argument(help: """
    A list of targets to focus on. \
    Other targets will be linked as binaries if possible. \
    If no target is specified, all the project targets will be generated (except external ones, such as Swift packages).
    """)
    var targets: [String] = []

    @Flag(
        name: .shortAndLong,
        help: "Don't open the project after generating it."
    )
    var noOpen: Bool = false

    @Flag(
        name: [.customShort("x"), .long],
        help: "When passed it uses frameworks (only simulator) for the cache instead of frameworks (simulator and device)."
    )
    var frameworks: Bool = false

    @Option(
        name: [.customShort("P"), .long],
        help: "The name of the cache profile to be used when focusing on the target."
    )
    var profile: String?

    @Flag(
        name: [.customLong("no-cache")],
        help: "Ignore cached targets, and use their sources instead."
    )
    var ignoreCache: Bool = false

    @Flag(
        name: .shortAndLong,
        help: "Instead of simple fetch, update external content when available."
    )
    var update: Bool = false

    func run() throws {
        try PrepareService()
            .run(
                path: path,
                targets: targets,
                noOpen: noOpen,
                xcframeworks: !frameworks,
                profile: profile,
                ignoreCache: ignoreCache,
                update: update
            )
    }
}
