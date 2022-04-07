# Tuist prepare plugin

A plugin that extends [Tuist](https://github.com/tuist/tuist) with a `prepare` command which allows to run `tuist fetch`, `tuist cache warm`, and `tuist generate` in a single shot.

## Install

In order to tell Tuist you'd like to use prepare plugin in your project follow the instructions that are described in [Tuist documentation](https://docs.tuist.io/plugins/using-plugins).

## Usage

The plugin provides a command for preparing the Xcode project. All you need to do is run the following command:

```
tuist prepare
```

You can pass all the parameters supported by the [`fetch`](https://docs.tuist.io/commands/dependencies), [`cache warm`](https://docs.tuist.io/building-at-scale/caching#warming-the-cache), and [`generate`](https://docs.tuist.io/commands/generate) commands.

```
tuist prepare --help
```

### Subcommands

| Subcommand               | Description                                 |
| ------------------------ | ------------------------------------------- |
| `tuist prepare version`  | Outputs the current version of the plugin.  |

## Contribute

To start working on the project, you can follow the steps below:
1. Clone the project.
2. Run `Package.swift` file. 
