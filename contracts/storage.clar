;; Storage Contract

;; Define data structures
(define-map files
  { file-id: uint }
  { owner: principal, hash: (string-ascii 64), size: uint }
)

(define-data-var last-file-id uint u0)

;; Error codes
(define-constant err-not-found (err u404))
(define-constant err-unauthorized (err u403))

;; Upload a file
(define-public (upload-file (hash (string-ascii 64)) (size uint))
  (let
    (
      (new-file-id (+ (var-get last-file-id) u1))
    )
    (map-set files
      { file-id: new-file-id }
      { owner: tx-sender, hash: hash, size: size }
    )
    (var-set last-file-id new-file-id)
    (ok new-file-id)
  )
)

;; Retrieve file details
(define-read-only (get-file (file-id uint))
  (map-get? files { file-id: file-id })
)

;; Delete a file
(define-public (delete-file (file-id uint))
  (let
    (
      (file (unwrap! (map-get? files { file-id: file-id }) err-not-found))
    )
    (asserts! (is-eq tx-sender (get owner file)) err-unauthorized)
    (map-delete files { file-id: file-id })
    (ok true)
  )
)

