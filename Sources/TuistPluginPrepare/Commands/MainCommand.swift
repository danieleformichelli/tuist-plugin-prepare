import ArgumentParser

/// The entry point of the plugin. Main command that must be invoked in `main.swift` file.
struct MainCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "plugin-prepare",
        abstract: "A plugin that extends Tuist with prepare command.",
        subcommands: [
            PrepareCommand.self, // performs fetch, cache, and generate
            VersionCommand.self, // prints version of the plugin
        ],
        defaultSubcommand: PrepareCommand.self
    )
}
