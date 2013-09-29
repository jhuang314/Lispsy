#!emacs --script

(require 'mongo)


(defun mongo-etsy ()
  (interactive)
;  (interactive "sSource: ")
  (if (get-buffer "foo.org")
      (kill-buffer "foo.org"))
  (get-buffer-create "foo.org")
  
  
  (defun processQuery (elem)
    (cdr (elt elem 2)))
  
  (let* ((result
	  (mongo-with-open-database
	      (db :host 'local)
	    (mongo-do-request
	     (make-mongo-message-query
	      :flags 0
	      :number-to-skip 0
	      :number-to-return 10
	      :full-collection-name "test.emacs"
	      :query '(("source" . "etsy" )))
	     :database db)))
	 (docres (mongo-message-reply-documents result)))
    (with-current-buffer "foo.org" (insert "Recent Etsy lookups (by url)\n"))
    (with-current-buffer "foo.org" (insert (message "%s\n" (mapconcat 'identity (mapcar 'processQuery docres) "\n"))))
    
					;    (with-current-buffer "foo.org" (insert '(("source" . "etsy"))))
					;    (with-current-buffer "foo.org" (insert (message "%s\n" '(("source" . (car src) )))))
					;    (with-current-buffer "foo.org" (insert (message "%s" '(("source" . "etsy" )))))
    (switch-to-buffer "foo.org")
    (let ((mode "org-mode"))
      (funcall (intern mode)))
					;    (print (car docres))
    )
  
  
  
)


(defun mongo-nyt ()
  (interactive)
;  (interactive "sSource: ")
  (if (get-buffer "foo.org")
      (kill-buffer "foo.org"))
  (get-buffer-create "foo.org")
  
  
  (defun processQuery (elem)
    (cdr (elt elem 2)))
  
  (let* ((result
	  (mongo-with-open-database
	      (db :host 'local)
	    (mongo-do-request
	     (make-mongo-message-query
	      :flags 0
	      :number-to-skip 0
	      :number-to-return 10
	      :full-collection-name "test.emacs"
	      :query '(("source" . "nyt" )))
	     :database db)))
	 (docres (mongo-message-reply-documents result)))
    (with-current-buffer "foo.org" (insert "Recent New York Times lookups (by url)\n"))
    (with-current-buffer "foo.org" (insert (message "%s\n" (mapconcat 'identity (mapcar 'processQuery docres) "\n"))))
    
					;    (with-current-buffer "foo.org" (insert (message "%s" '(("source" . "etsy" )))))
    (switch-to-buffer "foo.org")
    (let ((mode "org-mode"))
      (funcall (intern mode)))
					;    (print (car docres))
    )
  
  
  
)

(defun mongo-bitly ()
  (interactive)
;  (interactive "sSource: ")
  (if (get-buffer "foo.org")
      (kill-buffer "foo.org"))
  (get-buffer-create "foo.org")
  
  
  (defun processQuery (elem)
    (cdr (elt elem 2)))
  
  (let* ((result
	  (mongo-with-open-database
	      (db :host 'local)
	    (mongo-do-request
	     (make-mongo-message-query
	      :flags 0
	      :number-to-skip 0
	      :number-to-return 10
	      :full-collection-name "test.emacs"
	      :query '(("source" . "bitly" )))
	     :database db)))
	 (docres (mongo-message-reply-documents result)))
    (with-current-buffer "foo.org" (insert "Recent bit.ly urls browsed\n"))
    (with-current-buffer "foo.org" (insert (message "%s\n" (mapconcat 'identity (mapcar 'processQuery docres) "\n"))))
    
					;    (with-current-buffer "foo.org" (insert (message "%s" '(("source" . "etsy" )))))
    (switch-to-buffer "foo.org")
    (let ((mode "org-mode"))
      (funcall (intern mode)))
					;    (print (car docres))
    )
  
  
  
)