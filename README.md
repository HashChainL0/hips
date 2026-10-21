# Hash Chain Improvement Proposals (HIPs)

Design proposals for Hash Chain, the privacy Layer 0: its own network with its own validators, where accounts, payments, swaps, assets and apps are private by default, connected to Ethereum, Base, Robinhood Chain and Monero.

> **STATUS: pre-launch, spec stage.** Every HIP here is a proposal. Nothing described is deployed or audited. A Draft HIP is not a decision. The [protocol spec](https://github.com/HashChainL0/protocol-spec) describes the current design, and HIPs are how changes to it are proposed, argued and recorded.

## What a HIP is

A HIP is a short design document that describes one change, explains why, and records the objections. It is modelled on Ethereum Improvement Proposals and Bitcoin Improvement Proposals. Anyone can write one. The full rules are in [HIP-1](hips/hip-0001.md).

## Status lifecycle

| Status | Meaning |
| --- | --- |
| Idea | Discussed informally in an issue. |
| Draft | A pull request is open and the author is working on the text. |
| Review | The author asks for wider review. |
| Last Call | A final review window of at least fourteen days. |
| Final | Accepted. Only corrections and clarifications from here. |
| Withdrawn | The author has withdrawn the proposal. |
| Stagnant | No activity for six months. Can be revived. |

## Categories

| Category | Scope |
| --- | --- |
| Core | Consensus, validators, staking, accounts, proofs, privacy mechanisms |
| Networking | Peer to peer communication and data propagation |
| Interface | APIs, SDKs, wallet behaviour, app and token standards |
| Connection | Links to Ethereum, Base, Robinhood Chain and Monero |
| Meta | The HIP process itself |
| Informational | Background and guidelines with no required adoption |

## Index

| HIP | Title | Category | Status |
| --- | --- | --- | --- |
| [1](hips/hip-0001.md) | HIP Purpose and Process | Meta | Final |
| [2](hips/hip-0002.md) | Scoped view keys | Core | Draft |
| [3](hips/hip-0003.md) | Monero swap timelock parameters | Connection | Draft |

## How to submit

1. Open an issue with the "HIP idea" template and discuss the idea in public.
2. Copy [hip-template.md](hip-template.md) and fill it in. Keep to plain language and mark undecided points as "to be specified".
3. Run `scripts/check-frontmatter.sh`.
4. Open a pull request with one HIP. An editor assigns the number.
5. Respond to feedback in the open. The HIP moves through Review and Last Call to Final.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the style guide.

## Related repositories

- [protocol-spec](https://github.com/HashChainL0/protocol-spec): the written design of Hash Chain.
- [xmr-swap-model](https://github.com/HashChainL0/xmr-swap-model): a research model of the Monero swap, used by HIP-3.

## Security

Security reports go through [SECURITY.md](SECURITY.md). Participation is governed by the [Code of Conduct](CODE_OF_CONDUCT.md).

## Links

- Website: https://hashchain.network
- X: https://x.com/hashchainL0
- GitHub: https://github.com/HashChainL0

## License

Proposal text is released under [CC0 1.0](LICENSE). The Hash Chain name and logo are covered separately in the brand kit.
