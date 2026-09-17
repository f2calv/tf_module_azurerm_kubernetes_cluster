# Copilot Instructions

## Shared Instructions

Shared Copilot instruction files are maintained centrally in the [.github](https://github.com/f2calv/.github) repository under `instructions/`, and are applied to every workspace from the VS Code user profile via `~/.copilot/instructions`. They are deliberately not copied into this repository, so a change there takes effect everywhere without a pull request here.

Everything below is specific to this repository.

## Cluster Identifiers

A cluster rebuild issues a new API server endpoint and, where the caller attaches one, a new ingress address. Record such out-of-band follow-up steps in the root `README.md` rather than leaving them implicit for consumers.
