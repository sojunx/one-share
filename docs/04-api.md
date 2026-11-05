# API - oneShare

Base URL: `/api/v1`  
Auth: Bearer Token (JWT) required for all endpoints

---

## 1. Create Group
`POST /groups`

**Request body:**
```json
{
  "name": "Trip to Đà Lạt",
  "description": "Chi tiêu chung chuyến đi"
}
```

**Response:** `201 Created`
```json
{
  "id": "uuid",
  "name": "Trip to Đà Lạt",
  "description": "Chi tiêu chung chuyến đi",
  "createdAt": "2025-01-15T10:00:00Z",
  "createdBy": {
    "id": "uuid",
    "username": "hiepphat",
    "fullname": "Hiệp Phát"
  }
}
```

---

## 2. Add Member
`POST /groups/{groupId}/members`

**Request body:**
```json
{
  "username": "nguyenvana"
}
```

**Response:** `201 Created`
```json
{
  "id": "uuid",
  "user": {
    "id": "uuid",
    "username": "nguyenvana",
    "fullname": "Nguyễn Văn A"
  },
  "role": "Member",
  "joinedAt": "2025-01-15T10:05:00Z"
}
```

---

## 3. Add Expense
`POST /groups/{groupId}/expenses`

**Request body:**
```json
{
  "storeName": "Highlands Coffee",
  "description": "Cà phê sáng",
  "totalAmount": 150000,
  "payerId": "uuid-of-payer",
  "shares": [
    { "userId": "uuid-1", "amount": 50000 },
    { "userId": "uuid-2", "amount": 100000 }
  ]
}
```

**Response:** `201 Created`
```json
{
  "id": "uuid",
  "storeName": "Highlands Coffee",
  "description": "Cà phê sáng",
  "totalAmount": 150000,
  "payer": {
    "id": "uuid",
    "username": "hiepphat",
    "fullname": "Hiệp Phát"
  },
  "shares": [
    {
      "user": { "id": "uuid-1", "username": "...", "fullname": "..." },
      "amount": 50000
    },
    {
      "user": { "id": "uuid-2", "username": "...", "fullname": "..." },
      "amount": 100000
    }
  ],
  "createdAt": "2025-01-15T10:10:00Z"
}
```

---

## 4. List Expenses
`GET /groups/{groupId}/expenses?page=1&limit=20`

**Response:** `200 OK`
```json
{
  "items": [
    {
      "id": "uuid",
      "storeName": "Highlands Coffee",
      "description": "Cà phê sáng",
      "totalAmount": 150000,
      "payer": {
        "id": "uuid",
        "username": "hiepphat",
        "fullname": "Hiệp Phát"
      },
      "createdAt": "2025-01-15T10:10:00Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "totalItems": 5,
    "totalPages": 1
  }
}
```

---

## 5. Get Balance
`GET /groups/{groupId}/balances`

**Response:** `200 OK`
```json
{
  "balances": [
    {
      "fromUser": {
        "id": "uuid-1",
        "username": "nguyenvana",
        "fullname": "Nguyễn Văn A"
      },
      "toUser": {
        "id": "uuid-2",
        "username": "hiepphat",
        "fullname": "Hiệp Phát"
      },
      "amount": 75000
    }
  ]
}
```
> Meaning: `fromUser` owes `toUser` the `amount`

---

## 6. Create Payment
`POST /groups/{groupId}/payments`

**Request body:**
```json
{
  "toUserId": "uuid-of-receiver",
  "amount": 75000,
  "note": "Trả tiền cà phê"
}
```

**Response:** `201 Created`
```json
{
  "id": "uuid",
  "fromUser": {
    "id": "uuid",
    "username": "nguyenvana",
    "fullname": "Nguyễn Văn A"
  },
  "toUser": {
    "id": "uuid",
    "username": "hiepphat",
    "fullname": "Hiệp Phát"
  },
  "amount": 75000,
  "note": "Trả tiền cà phê",
  "createdAt": "2025-01-15T11:00:00Z"
}
```

---

## Common Error Responses

| Status | Meaning                            |
|--------|------------------------------------|
| 400    | Validation error / business rule   |
| 401    | Unauthenticated                    |
| 403    | Forbidden (not member / not admin) |
| 404    | Resource not found                 |
| 409    | Conflict (e.g. user already in group) |
```
