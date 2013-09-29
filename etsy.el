#!emacs --script

(defun etsy-listing (n)
  "get most recent etsy listings"
  (interactive "nListing Limit: ")
  
  (if (get-buffer "foo.org")
      (kill-buffer "foo.org"))
  (get-buffer-create "foo.org")
  
  
  (defun processEtsy (elem)
    (if (not (vectorp elem)) 
	(concat (cdr (assoc 'title elem)) "\nPrice:" (cdr (assoc 'price elem)) " " (cdr (assoc 'currency_code elem)) "\n" (cdr (assoc 'url elem)) )))
  
  
  
  (let* ((etsyData (with-current-buffer (url-retrieve-synchronously (format "https://openapi.etsy.com/v2/listings/active?api_key={KEY}" n))
		     (goto-char url-http-end-of-headers)
		     (json-read)))
	 (etsyListing (cdr (assoc 'results etsyData)))
	 )
    
     (with-current-buffer "foo.org" (insert (format "Top %d Most Recent ETSY Listings\n" n)))
     (with-current-buffer "foo.org" (insert (mapconcat 'identity (mapcar 'processEtsy etsyListing) "\n\n" )))
     (switch-to-buffer "foo.org")
     (let ((mode "org-mode"))
       (funcall (intern mode)))
     
     )
  
  
  
  
)
