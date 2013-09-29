#!emacs --script

(defun bitly-popular (n)
  "get popular bitly urls"

  (interactive "nUrl Limit: ")
  
  (if (get-buffer "foo.org")
      (kill-buffer "foo.org"))
  (get-buffer-create "foo.org")
  
  
  (let* ((bitlyData (with-current-buffer (url-retrieve-synchronously (format "https://api-ssl.bitly.com/v3/highvalue?access_token={KEY}" n))
	 (goto-char url-http-end-of-headers)
	 (json-read)))
	 (bitlyLinks (cdr (assoc 'values (cddr (assoc 'data bitlyData))))))
    
    (with-current-buffer "foo.org" (insert (format "Top %d most popular bit.ly links\n" n)))
    (with-current-buffer "foo.org" (insert (mapconcat 'identity bitlyLinks "\n")))
    
    (switch-to-buffer "foo.org")
    (let ((mode "org-mode"))
      (funcall (intern mode)))
    )
)
