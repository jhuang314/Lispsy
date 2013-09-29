#!emacs --script

(defun nyt-search (q)
  "search nyt articles"
  (interactive "sQuery: ")
  
  (if (get-buffer "foo.org")
      (kill-buffer "foo.org"))
  (get-buffer-create "foo.org")
  
  
  (defun processDocs (elem)
    (if (not (vectorp elem)) 
	(concat (cdr (assoc 'source elem)) "\n:" (cdr (assoc 'snippet elem)) "\n" (cdr (assoc 'web_url elem)) )))
  
  
  
  (let* ((baseurl "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=%s&api-key=KEY")
	 (q (w3m-url-encode-string q))
	 
	 (nytData (with-current-buffer (url-retrieve-synchronously (format baseurl q))
		    (goto-char url-http-end-of-headers)
		    (json-read)))
	 (nytDocs  (cdr (cadr (assoc 'response nytData))))
;	 (nytDocs (assoc 'response nytData))
	 )
    
    (with-current-buffer "foo.org" (insert (mapconcat 'identity (mapcar 'processDocs nytDocs) "\n\n" )))
    
    (switch-to-buffer "foo.org")
    (let ((mode "org-mode"))
      (funcall (intern mode)))
    
    )
  
)
