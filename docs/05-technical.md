# Technical Breakdown - oneShare

**Stack:**
- Backend: Java (Spring Boot)
- Frontend: React + Vite + TanStack Router
- Database: PostgreSQL
- Infra: Docker + CI/CD

---

## 1. Project Setup

### Backend
- [ ] Initialize Spring Boot project
- [ ] Setup PostgreSQL connection
- [ ] Setup Spring Data JPA
- [ ] Setup Spring Security + JWT
- [ ] Setup project structure (Controller → Service → Repository → Entity)
- [ ] Setup MapStruct / DTO mapping
- [ ] Setup Validation (Hibernate Validator)

### Frontend
- [ ] Initialize React + Vite project
- [ ] Setup TanStack Router
- [ ] Setup TanStack Query (React Query)
- [ ] Setup Axios / Fetch client
- [ ] Setup Auth context / token storage
- [ ] Setup basic layout + routing

### Infra
- [ ] Write `Dockerfile` for backend
- [ ] Write `Dockerfile` for frontend
- [ ] Write `docker-compose.yml` (backend + frontend + postgres)
- [ ] Setup CI/CD pipeline (GitHub Actions / GitLab CI)

---

## 2. Domain / Entity Layer (Backend)

- [ ] Create `User` entity
- [ ] Create `Group` entity
- [ ] Create `GroupMember` entity + `Role` enum
- [ ] Create `Expense` entity
- [ ] Create `ExpenseShare` entity
- [ ] Create `Payment` entity
- [ ] Create base audit fields (`createdAt`, etc.)

---

## 3. Repository Layer

- [ ] `UserRepository`
- [ ] `GroupRepository`
- [ ] `GroupMemberRepository`
- [ ] `ExpenseRepository`
- [ ] `ExpenseShareRepository`
- [ ] `PaymentRepository`

---

## 4. Use Cases / Service Layer

### Group
- [ ] `CreateGroupService`
- [ ] `AddMemberService`

### Expense
- [ ] `AddExpenseService` (validate sum of shares = totalAmount)
- [ ] `ListExpensesService`

### Balance & Payment
- [ ] `GetBalanceService` (calculate net balances from expenses + payments)
- [ ] `CreatePaymentService`

---

## 5. API Layer (Controllers)

- [ ] `POST /api/v1/groups`
- [ ] `POST /api/v1/groups/{groupId}/members`
- [ ] `POST /api/v1/groups/{groupId}/expenses`
- [ ] `GET  /api/v1/groups/{groupId}/expenses`
- [ ] `GET  /api/v1/groups/{groupId}/balances`
- [ ] `POST /api/v1/groups/{groupId}/payments`
- [ ] Global Exception Handler
- [ ] Request DTOs + Validation annotations

---

## 6. Database

- [ ] Create migration for `users`
- [ ] Create migration for `groups`
- [ ] Create migration for `group_members`
- [ ] Create migration for `expenses`
- [ ] Create migration for `expense_shares`
- [ ] Create migration for `payments`
- [ ] Add indexes (`group_id`, `user_id`...)

---

## 7. Frontend Features

- [ ] Login / Register pages
- [ ] Create Group page
- [ ] Group Detail page (members + expenses + balances)
- [ ] Add Member form
- [ ] Add Expense form (dynamic shares)
- [ ] List Expenses
- [ ] Balance summary view
- [ ] Create Payment form
- [ ] Auth guard (protected routes)

---

## 8. Docker & CI/CD

### Docker
- [ ] Backend Dockerfile (multi-stage build)
- [ ] Frontend Dockerfile (build + nginx)
- [ ] `docker-compose.yml` (app + db)
- [ ] Environment variables (`.env`)

### CI/CD (GitHub Actions example)
- [ ] Job: Build & Test backend
- [ ] Job: Build frontend
- [ ] Job: Build Docker images
- [ ] Job: Push images to registry
- [ ] Job: Deploy (optional)

---

## 9. Testing

### Backend
- [ ] Unit test `AddExpenseService` (share validation)
- [ ] Unit test `GetBalanceService`
- [ ] Unit test `CreatePaymentService`
- [ ] Integration test main flows

---

## 10. Nice-to-have (Later)
- [ ] List my groups
- [ ] Remove member
- [ ] Edit / Delete expense
- [ ] Expense detail page
- [ ] Real-time update (WebSocket)
