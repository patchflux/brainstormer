---
description: Generate product and technical specs from validated clarification
---

<command>
Execute the workflow defined in `workflows/specs.md`.

This command generates specs ONLY after clarification reaches "Ready for Specs" status.

**Usage:**
```
/brainstorm:specs
```

**Outputs:**
- `.brainstorm/PRODUCT_SPEC.md` — Product specification
- `.brainstorm/TECHNICAL_SPEC.md` — Technical specification

These specs are designed to feed into GSD's `/gsd:new-project --auto` command.
</command>
