;; File Sharing Contract

;; Define data structures
(define-map file-permissions
  { file-id: uint, user: principal }
  { can-read: bool, can-write: bool }
)

;; Grant permission
(define-public (grant-permission (file-id uint) (user principal) (can-read bool) (can-write bool))
  (ok (map-set file-permissions
    { file-id: file-id, user: user }
    { can-read: can-read, can-write: can-write }
  ))
)

;; Check permission
(define-read-only (check-permission (file-id uint) (user principal))
  (default-to
    { can-read: false, can-write: false }
    (map-get? file-permissions { file-id: file-id, user: user })
  )
)

;; Revoke permission
(define-public (revoke-permission (file-id uint) (user principal))
  (ok (map-delete file-permissions { file-id: file-id, user: user }))
)

