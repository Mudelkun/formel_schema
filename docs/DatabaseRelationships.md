# Database Relationships — Formel

## Tables Overview

| Table | Purpose |
|---|---|
| `students` | Core student profile |
| `contacts` | Parent/guardian contact info per student |
| `student_documents` | Uploaded dossier files per student |
| `classes` | Grade levels and their tuition fees |
| `school_years` | Academic year definitions |
| `enrollments` | Links a student to a class for a given school year |
| `payments` | Payment records tied to an enrollment |
| `payment_documents` | Proof of payment files per payment |
| `users` | Admin, staff, accountant, and teacher accounts |

---

## Relationships

### students → contacts (1 to many)
One student can have multiple contacts (parents, guardians).
`contacts.student_id` → `students.id`

### students → student_documents (1 to many)
One student can have multiple uploaded documents (birth certificate, ID card, transcript, etc.).
`student_documents.student_id` → `students.id`

### students → enrollments (1 to many)
One student can be enrolled once per school year (enforced by unique index on `student_id + school_year_id`).
`enrollments.student_id` → `students.id`

### classes → enrollments (1 to many)
One class can have many students enrolled in it.
`enrollments.class_id` → `classes.id`

### school_years → enrollments (1 to many)
One school year groups all enrollments that happen during that period.
`enrollments.school_year_id` → `school_years.id`

### enrollments → payments (1 to many)
One enrollment can have multiple payments (e.g. semester installments).
`payments.enrollment_id` → `enrollments.id`

### payments → payment_documents (1 to many)
One payment can have multiple proof documents (receipts, bank slips).
`payment_documents.payment_id` → `payments.id`

---

## Full Chain

```
students
  ├── contacts              (parent/guardian info)
  ├── student_documents     (dossier files stored in R2)
  └── enrollments
        ├── classes         (grade level + tuition fee)
        ├── school_years    (academic year)
        └── payments
              └── payment_documents   (proof of payment stored in R2)

users                       (standalone — admin, staff, accountant, teacher accounts)
```

---

## Key Constraints

- A student can only be enrolled **once per school year** (`UNIQUE` on `enrollments.student_id + school_year_id`)
- Only **one school year** can be active at a time (`UNIQUE` partial index on `school_years.is_active WHERE is_active = true`)
- Students are **never deleted** — use `status` field: `active`, `inactive`, `expelled`, `graduated`
- Scholarship students (`scholarship_recipient = true`) are exempt from tuition payments
