# Copilot Instructions for the `dotjitsu` Repository

Welcome to the `dotjitsu` repository! This document provides guidance for AI coding agents to be productive and effective contributors to this codebase. Below are the key aspects of the project structure, workflows, and conventions.

## Project Overview

The `dotjitsu` repository is a collection of scripts, configurations, and utilities designed to enhance developer productivity and system management. It includes:

- **Scripts**: Located in `bin/`, these scripts automate various tasks such as process management, file compression, and system cleanup.
- **Configurations**: Found in the root directory and `etc/`, these files configure tools like `aria2`, `neofetch`, and `starship`.
- **Packages**: Managed dependencies and package configurations are stored in `packages/`.

## Key Directories and Files

- `bin/`: Contains executable scripts. Examples include:
  - `autokill`: Monitors and kills processes based on CPU time, runtime, or port usage.
  - `cleanup`: Automates system cleanup tasks.
- `etc/`: Configuration files for various tools.
- `Brewfile`: Defines Homebrew dependencies.
- `README.md`: Provides an overview of the repository.

## Developer Workflows

### Running Scripts

Scripts in the `bin/` directory can be executed directly. Ensure they have executable permissions:

```bash
chmod +x bin/<script_name>
./bin/<script_name>
```

### Managing Dependencies

- **Homebrew**: Install dependencies using the `Brewfile`:
  ```bash
  brew bundle --file=Brewfile
  ```
- **Node.js**: Use `pnpm` for package management:
  ```bash
  pnpm install
  ```

### Testing and Debugging

- Scripts often include `--help` options for usage details.
- Use `dry-run` modes (e.g., in `autokill`) to preview actions without making changes.

## Project-Specific Conventions

- **Script Logging**: Many scripts support logging to a file or stdout with colored output.
- **Graceful Shutdown**: Scripts like `autokill` attempt graceful termination (SIGTERM) before forcefully killing processes (SIGKILL).
- **Cross-Platform Compatibility**: Ensure GNU utilities (e.g., `gdate`) are installed on macOS.
- **Shell script conventions**:
 - Use `#!/usr/bin/env bash` shebang for portability.
 - Prefer `set -euo pipefail` to catch errors early.
 - **Script Documentation**: Each script should have a header comment explaining its purpose, usage, and options.
 - **Logging**: Use consistent logging practices, such as `echo` for stdout and `logger` for system logs.
 - **Exit Codes**: Scripts should exit with appropriate status codes (0 for success, non-zero for errors) to indicate success or failure.
 - **Dry-run Options**: Where applicable, scripts should support a `--dry-run` option to simulate actions without making changes, allowing users to preview what would happen without executing the commands.
 - **Error Handling**: Scripts should handle errors gracefully, logging them appropriately and exiting with a non-zero status when necessary.
 - **Script Header Comments**: Each script should begin with a comment block that includes:
   - Purpose of the script
   - Usage instructions
   - Options and flags supported
   - Example commands
 - **Variiable Naming**: Use descriptive variable names in scripts to enhance readability and maintainability.
 - **Function Definitions**: Use functions to encapsulate logic within scripts, improving modularity and readability. For bash scripts, define functions using the `function-name() { ... }` syntax with dash-case/ kebab-case


## Integration Points

- **External Tools**: Scripts rely on tools like `aria2`, `neofetch`, and `coreutils`. Ensure these are installed and configured.
- **Environment Variables**: Some scripts may depend on specific environment variables. Check the script headers for details.

## Examples

### Using `autokill`

```bash
# Kill processes exceeding 80% CPU usage
./bin/autokill --max-cpu-percent 80 process_name

# Dry-run mode to preview actions
./bin/autokill --dry-run process_name
```

### Cleaning Up the System

```bash
# Run the cleanup script
./bin/cleanup
```

## Notes for AI Agents

- Focus on maintaining cross-platform compatibility.
- Follow the existing logging and error-handling patterns.
- When adding new scripts, place them in `bin/` and document their usage in `README.md`.

For any questions or clarifications, refer to the `README.md` or existing script headers.
