(defmodule behaviour-macros-sup
  (behaviour supervisor)
  ;; API & Supervisor callbacks
  (export all))

(include-file "include/macros.lfe")

(defsup 'behaviour-macros-sup
        'behaviour-macros-server)



