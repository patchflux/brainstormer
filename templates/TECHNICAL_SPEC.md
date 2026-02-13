# Technical Spec: {{product_name}}

**Version:** 0.1 (MVP)
**Status:** Ready for Implementation
**Last Updated:** {{timestamp}}

---

## Architecture Overview

### System Type
{{web_app/mobile/cli/api/desktop}}

### High-Level Architecture
```
{{ascii_diagram}}
```

### Core Components

| Component | Responsibility | Technology |
|-----------|---------------|------------|
| {{component}} | {{what_it_does}} | {{stack}} |
| {{component}} | {{what_it_does}} | {{stack}} |
| {{component}} | {{what_it_does}} | {{stack}} |

---

## Technology Stack

### Chosen Stack

| Layer | Choice | Rationale |
|-------|--------|-----------|
| Frontend | {{tech}} | {{why}} |
| Backend | {{tech}} | {{why}} |
| Database | {{tech}} | {{why}} |
| Hosting | {{tech}} | {{why}} |
| Auth | {{tech}} | {{why}} |

### Rejected Alternatives

| Layer | Rejected | Why Not |
|-------|----------|---------|
| {{layer}} | {{tech}} | {{reason}} |

---

## Data Model

### Core Entities

**{{entity_1}}**
```
{
  id: UUID
  {{field}}: {{type}} — {{description}}
  {{field}}: {{type}} — {{description}}
  created_at: timestamp
  updated_at: timestamp
}
```

**{{entity_2}}**
```
{
  id: UUID
  {{field}}: {{type}} — {{description}}
  {{field}}: {{type}} — {{description}}
  created_at: timestamp
  updated_at: timestamp
}
```

### Relationships
```
{{entity_1}} --< {{entity_2}}  (one-to-many)
{{entity_1}} >--< {{entity_3}} (many-to-many)
```

---

## API Design

### Endpoints (MVP)

**{{resource}}**
| Method | Path | Description | Auth |
|--------|------|-------------|------|
| GET | /api/{{resource}} | List all | {{yes_no}} |
| POST | /api/{{resource}} | Create | {{yes_no}} |
| GET | /api/{{resource}}/:id | Get one | {{yes_no}} |
| PUT | /api/{{resource}}/:id | Update | {{yes_no}} |
| DELETE | /api/{{resource}}/:id | Delete | {{yes_no}} |

### Request/Response Examples

**Create {{resource}}**
```json
// Request
POST /api/{{resource}}
{
  "{{field}}": "{{value}}",
  "{{field}}": "{{value}}"
}

// Response 201
{
  "id": "{{uuid}}",
  "{{field}}": "{{value}}",
  "created_at": "{{timestamp}}"
}
```

---

## Implementation Phases

### Phase 1: Foundation
- [ ] Project setup (repo, CI, deployment)
- [ ] Database schema + migrations
- [ ] Auth system
- [ ] Basic API structure

### Phase 2: Core Features
- [ ] {{feature_1_from_product_spec}}
- [ ] {{feature_2_from_product_spec}}

### Phase 3: Polish
- [ ] {{feature_3_from_product_spec}}
- [ ] Error handling
- [ ] Basic monitoring

### Phase 4: Launch
- [ ] Production deployment
- [ ] Monitoring/alerting
- [ ] Documentation

---

## External Dependencies

| Service | Purpose | Cost | Alternative |
|---------|---------|------|-------------|
| {{service}} | {{what_for}} | {{cost}} | {{backup}} |

---

## Security Considerations

### Authentication
{{approach_jwt_session_oauth}}

### Authorization
{{approach_rbac_abac_simple}}

### Data Protection
- [ ] Input validation: {{approach}}
- [ ] SQL injection: {{approach}}
- [ ] XSS: {{approach}}
- [ ] HTTPS: {{approach}}

---

## Performance Targets (MVP)

| Metric | Target | Measurement |
|--------|--------|-------------|
| Page load | < {{X}}s | {{tool}} |
| API response | < {{X}}ms | {{tool}} |
| Concurrent users | {{N}} | {{tool}} |

---

## Open Technical Questions

1. {{question}} — decide before {{phase}}
2. {{question}} — decide before {{phase}}

---

*Derived from Product Spec v0.1*
