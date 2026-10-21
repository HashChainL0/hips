# Contributing

Thanks for reading the proposals closely. Hash Chain is at the spec stage, so careful criticism is the most useful contribution.

## Ways to contribute

- **Discuss an idea** before writing it. Use the "HIP idea" issue template.
- **Write a HIP.** Follow the steps in [README.md](README.md) and [HIP-1](hips/hip-0001.md), using [hip-template.md](hip-template.md).
- **Review a draft.** Comment on open pull requests. Point out gaps, wrong assumptions and unclear wording.
- **Fix small things** such as typos and broken links directly with a pull request.
- **Report a security problem** privately. Do not open a public issue. See [SECURITY.md](SECURITY.md).

## Pull request process

1. Fork the repository and create a branch.
2. One HIP per pull request.
3. Name the file `hips/hip-NNNN.md`. Editors assign the number, so use a placeholder such as `hip-9999.md` until then.
4. Run `scripts/check-frontmatter.sh` before opening the pull request.
5. A maintainer reviews. Substantive changes may need discussion in the pull request before merging.

## Style guide

- **Plain first, technical second.** Short sentences. Explain terms on first use.
- **Honest status.** Mark designs as designs. Never describe a draft as audited, deployed or proven.
- **No invented numbers.** No throughput, fee, price, user or date figures unless they come from a cited, reproducible source. Use symbols such as T0 and T1 for timing parameters. Worked examples must be labelled as examples.
- **Unspecified means unspecified.** If something is undecided, write "to be specified" and list it under Open questions.
- **Consistent names.** Use the terms in the [protocol spec glossary](https://github.com/HashChainL0/protocol-spec/blob/main/docs/glossary.md). The project name is written "Hash Chain".
- **Punctuation.** Use commas, colons and periods. Do not use em dashes.
- **Keywords.** Where normative language is needed, use MUST, SHOULD and MAY in capitals with their usual meaning.

## Code of Conduct

By taking part you agree to follow the [Code of Conduct](CODE_OF_CONDUCT.md).

## License

By contributing you agree that your contribution is released under CC0 1.0, the same as the rest of the repository.
