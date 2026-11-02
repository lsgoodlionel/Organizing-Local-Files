# Plan CSV schema

Required columns:

| Column | Meaning |
|---|---|
| `SourcePath` | Absolute original file path from the frozen inventory |
| `TargetPath` | Absolute proposed terminal file path |
| `SizeBytes` | Source size recorded during inventory |
| `ModifiedUtc` | Source modification time in ISO 8601 UTC form |

Optional columns such as `Category`, `Rule`, `Confidence`, and `ManualReview` may explain the mapping but do not change execution behavior.

Every baseline file must occur exactly once. Targets must be absolute and lie under an explicitly approved root. A low-confidence record should target a clearly named manual-review or historical holding folder rather than a formal archive.
