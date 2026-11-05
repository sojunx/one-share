# Use Cases - oneShare 

## 1. Create group
**Actor:** Registered user  
**Goal:** Create a new shared expense group  

**Main flow:**  
1. User provides group name and optional description  
2. System validates the input  
3. System creates the group  
4. System adds the creator as Admin and Member  
5. System returns the newly created group  

**Business rules:**  
- Group name is required and cannot be empty or only whitespace  
- Description is optional  
- Creator is automatically assigned both Admin and Member roles  

**Errors:**  
- Empty or invalid group name → 400 Bad Request  
- Unauthenticated user → 401 Unauthorized  

---

## 2. Add member
**Actor:** Group Admin  
**Goal:** Add a user to an existing expense group  

**Main flow:**  
1. Admin provides the username of the user to add  
2. System validates that the user exists  
3. System checks that the user is not already a member of the group  
4. System adds the user to the group with Member role  
5. System returns the added member information  

**Business rules:**  
- Only users with Admin role in the group can add members  
- Target user must exist in the system  
- Target user must not already be a member of the group  
- New member is always added with Member role (not Admin)  

**Errors:**  
- User not found → 404 Not Found  
- User already in the group → 409 Conflict  
- Caller is not an Admin of the group → 403 Forbidden  
- Unauthenticated user → 401 Unauthorized  

---

## 3. Add expense
**Actor:** Group Member  
**Goal:** Record a new expense (bill) in the group  

**Main flow:**  
1. Member provides store name, optional description, total amount, payer, and list of sharers with their individual amounts  
2. System validates all inputs  
3. System saves the expense  
4. System recalculates balances for all involved members  
5. System returns the created expense  

**Business rules:**  
- Store name is required  
- Description is optional  
- Total amount must be greater than 0  
- Payer must be a member of the group  
- All sharers must be members of the group  
- Only members who actually shared the expense are included in the sharers list (members who did not buy anything are simply not listed)  
- Each listed sharer must have an individual amount greater than 0  
- Sum of all sharers' amounts must equal the total amount  
- Only group members can create expenses  

**Errors:**  
- Missing store name → 400 Bad Request  
- Total amount ≤ 0 → 400 Bad Request  
- Any sharer amount ≤ 0 → 400 Bad Request  
- Sum of sharers' amounts does not equal total amount → 400 Bad Request  
- Payer or any sharer is not a group member → 400 Bad Request  
- Caller is not a group member → 403 Forbidden  
- Unauthenticated user → 401 Unauthorized  

---

## 4. List expenses
**Actor:** Group Member  
**Goal:** Retrieve the list of expenses in a group  

**Main flow:**  
1. Member requests the list of expenses for a group (with optional pagination parameters)  
2. System validates that the caller is a member of the group  
3. System returns the list of expenses ordered by creation date (newest first)  

**Business rules:**  
- Only group members can view expenses  
- Results support pagination (page, limit)  
- Default sort is by creation date descending  

**Errors:**  
- Caller is not a group member → 403 Forbidden  
- Group not found → 404 Not Found  
- Unauthenticated user → 401 Unauthorized  

---

## 5. Get balance
**Actor:** Group Member  
**Goal:** View current balances between members in the group  

**Main flow:**  
1. Member requests the balance summary of a group  
2. System validates that the caller is a member of the group  
3. System calculates net balances between all members based on expenses and settlements  
4. System returns the balance summary (who owes whom and how much)  

**Business rules:**  
- Only group members can view balances  
- Balances are calculated from all expenses and settlements in the group  
- Net amounts are shown (simplified debts)  

**Errors:**  
- Caller is not a group member → 403 Forbidden  
- Group not found → 404 Not Found  
- Unauthenticated user → 401 Unauthorized  

---

## 6. Settle debt
**Actor:** Group Member  
**Goal:** Record a payment that settles a debt between two members  

**Main flow:**  
1. Member provides the recipient, amount, and optional note  
2. System validates the inputs  
3. System creates a settlement record  
4. System updates the balances of both members  
5. System returns the created settlement  

**Business rules:**  
- Amount must be greater than 0  
- Both the payer (caller) and the recipient must be members of the group  
- A member can only settle their own debt (cannot settle on behalf of others)  
- Settlement reduces the outstanding balance between the two members  

**Errors:**  
- Amount ≤ 0 → 400 Bad Request  
- Recipient is not a group member → 400 Bad Request  
- Caller is not a group member → 403 Forbidden  
- Group not found → 404 Not Found  
- Unauthenticated user → 401 Unauthorized
