# Backend Tech Stack — Formel

## Database
- **PostgreSQL** hosted on **Railway**

## ORM
- **DrizzleORM** — connects the backend to PostgreSQL

## File Storage
- **Cloudflare R2**
  - Upload student documents, payment proofs, and other files
  - Returns a public URL per file, stored in the database

### R2 Upload Flow
1. Backend receives file upload
2. Backend sends file to R2 via S3-compatible API
3. R2 returns a public URL (e.g. `https://pub-xxx.r2.dev/formel-docs/receipt.pdf`)
4. URL is stored in PostgreSQL via DrizzleORM
