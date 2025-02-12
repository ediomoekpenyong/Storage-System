;; Payment Contract

;; Define fungible token for payments
(define-fungible-token storage-token)

;; Error codes
(define-constant err-insufficient-balance (err u100))

;; Make a payment
(define-public (make-payment (recipient principal) (amount uint))
  (ft-transfer? storage-token amount tx-sender recipient)
)

;; Get balance
(define-read-only (get-balance (user principal))
  (ft-get-balance storage-token user)
)

;; Mint tokens (for testing purposes)
(define-public (mint-tokens (amount uint))
  (ft-mint? storage-token amount tx-sender)
)

