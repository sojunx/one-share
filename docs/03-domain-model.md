# Domain Model - oneShare

## 1. Entities

### User
- **id**: UUID
- **username**: string (unique)
- **fullname**: string
- **createdAt**: datetime

### Group
- **id**: UUID
- **name**: string
- **description**: string? (optional)
- **createdAt**: datetime
- **createdBy**: User

### GroupMember
- **id**: UUID
- **group**: Group
- **user**: User
- **role**: Role (Admin | Member)
- **joinedAt**: datetime

### Expense
- **id**: UUID
- **group**: Group
- **storeName**: string
- **description**: string? (optional)
- **totalAmount**: Money
- **payer**: User
- **createdAt**: datetime
- **shares**: List<ExpenseShare>

### ExpenseShare
- **id**: UUID
- **expense**: Expense
- **user**: User
- **amount**: Money

### Payment
- **id**: UUID
- **group**: Group
- **fromUser**: User          // người trả tiền
- **toUser**: User            // người nhận tiền
- **amount**: Money
- **note**: string? (optional)
- **createdAt**: datetime

---

## 2. Value Objects

### Money
- **amount**: decimal (precision 2)
- **currency**: string (default: "VND")
- Must be > 0 when used in Expense or Payment

### Role
- Enum: `Admin` | `Member`

---

## 3. Core Business Rules

### Group
- Group name cannot be empty or whitespace only
- Creator is automatically added as both Admin and Member

### GroupMember
- A user can only belong to a group once
- Only Admin can add new members
- New members are always added with role = Member

### Expense
- `storeName` is required
- `totalAmount` must be > 0
- `payer` must be a member of the group
- Every `ExpenseShare.user` must be a member of the group
- Only members who actually shared the expense appear in `shares`
- Each `ExpenseShare.amount` must be > 0
- Sum of all `ExpenseShare.amount` must equal `Expense.totalAmount`
- Only group members can create an expense

### Payment
- `amount` must be > 0
- Both `fromUser` and `toUser` must be members of the group
- A user can only create a payment where they are the `fromUser` (cannot pay on behalf of others)

### Balance (Calculated)
- Balance between two members is derived from:
  - All Expenses (who paid vs who owed)
  - All Payments
- Net amount is simplified (A owes B X, instead of mutual debts)
