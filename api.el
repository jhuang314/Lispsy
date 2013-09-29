#!emacs --script
(require 'json)


(defvar bitlyData (with-current-buffer (url-retrieve-synchronously "https://api-ssl.bitly.com/v3/highvalue?access_token={APIKEY}")
	 (goto-char url-http-end-of-headers)
	 ;; (prog1
	 ;;     (buffer-string)
	 ;;   (kill-buffer)))
	 (json-read)))

(defvar bitlyLinks (cdr (assoc 'values (cddr (assoc 'data bitlyData)))))

(message "data: %s" (cdr (assoc 'values (cddr (assoc 'data bitlyData)))))

;;(print (elt bitlyLinks 3))

(if (get-buffer "foo.org")
    (kill-buffer "foo.org"))
(get-buffer-create "foo.org")

(with-current-buffer "foo.org" (insert "Top 20 most popular bit.ly links\n"))
(with-current-buffer "foo.org" (insert (mapconcat 'identity bitlyLinks "\n")))

(switch-to-buffer "foo.org")
(let ((mode "org-mode"))
  (funcall (intern mode)))

(defvar etsyData (with-current-buffer (url-retrieve-synchronously "https://openapi.etsy.com/v2/listings/active?api_key={APIKEY}")
		   (goto-char url-http-end-of-headers)
		   (json-read)))

(defvar etsyListing (cdr (assoc 'results etsyData)))
(with-current-buffer "foo.org" (insert "\nEtsy stuff\n"))
(defun processEtsy (elem)
  (if (not (vectorp elem)) 
      (concat (cdr (assoc 'title elem)) "\n" (cdr (assoc 'url elem)) )))
;(print (mapcar 'processEtsy etsyListing))
(with-current-buffer "foo.org" (insert (mapconcat 'identity (mapcar 'processEtsy etsyListing) "\n\n" )))
;(with-current-buffer "foo.org" (insert (mapconcat ' etsyListing "\n")))
;(print etsyListing)
;(print (mapconcat 'identity etsyListing "\n"))
