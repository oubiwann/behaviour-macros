(defmacro defgenserver
  'noop)

(defmacro defgenfsm
  'noop)

(defmacro defgenevent
  'noop)

(defmacro defsup (supervisor-name server-name)
  `(progn
    (defun server-name ()
      ',supervisor-name)

    (defun start_link ()
      (supervisor:start_link
        (tuple 'local (server-name)) (MODULE) '()))

    (defun init (args)
      (let* ((server (tuple
                       ',server-name
                       (tuple ',server-name 'start_link '())
                       'permanent
                       2000
                       'worker
                       (list ',server-name)
                       ))
             (children (list server))
             (restart-strategy (tuple 'one_for_one 3 1)))
        (tuple 'ok (tuple restart-strategy children))))))

(defmacro defapp (supervisor-name)
  `(progn
     (defun start (type args)
       (let ((result (call ,supervisor-name 'start_link)))
         (case result
           ((tuple 'ok pid)
             result)
           (_
             (tuple 'error result)))))

     (defun stop (state)
       'ok)))
