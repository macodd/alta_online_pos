# alta_online_pos

A Flutter application for Merchants to charge clients using cash, QR code, or credit cards.

## Functionality

App uses firebase/firestore as its backend service.
App flow is as follows:
- Login
- Start new transaction
- Select between processing a new item or a pre-saved item stored in the database.
- Show total of current transaction
- Search for a client in the database (if client doesn't exist add it.) 
- Confirm correct information of the client.
- Capture payment.
- Show transaction completed/failed.

Payment process can be done using any backend payment platform (Stripe/PayPal).

