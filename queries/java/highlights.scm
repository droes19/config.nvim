;; extends
(package_declaration
  (scoped_identifier
    scope: (scoped_identifier)) @module (#set! priority 110))
(import_declaration
  (scoped_identifier
    scope: (scoped_identifier) @module (#set! priority 110)))
; (import_declaration
;   (scoped_identifier
;     name: (identifier) @type (#set! priority 110)))
; (method_invocation
;   object: (identifier) @property)
; ((method_invocation
;   object: (identifier) @type)
;   (#lua-match? @type "^[A-Z]"))
