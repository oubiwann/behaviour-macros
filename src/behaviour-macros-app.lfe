(defmodule behaviour-macros-app
  (behaviour application)
  (export all))

(include-file "include/macros.lfe")

(defapp 'behaviour-macros-sup)
