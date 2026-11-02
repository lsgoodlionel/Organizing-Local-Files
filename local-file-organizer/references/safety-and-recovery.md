# Safety and recovery

## Before execution

- Keep the drive connected and prevent sleep or automatic disconnection.
- Put the state directory on the source volume when possible so staging uses atomic same-volume moves.
- Preserve the inventory, plan, and state directory together.
- Review mappings at every top-level boundary; sample large and low-confidence categories.
- Stop if counts or bytes differ from the frozen inventory.

## Conflict behavior

- Missing target: place the staged file.
- Existing same-size, byte-identical target: move the source copy to the duplicate isolation directory. Do not delete it automatically.
- Existing different target: move the staged file to the conflict isolation directory.
- No content hash is written to inventory or journals.

## Recovery

Rollback uses the results journal, stages terminal files, then restores original paths. It refuses to overwrite an original path that has reappeared. Keep isolated duplicates and conflicts until rollback is no longer required.

## Stop conditions

Stop immediately on target-boundary violations, source-size drift, corrupt journals, an occupied original path during rollback, or unexplained count/byte differences.
