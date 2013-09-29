#!emacs --script

(defvar fb-url "https://www.googleapis.com/freebase/v1/search")

(defun fbquery (type str)
  (let ((url-request-method "GET")
	(arg-stuff (concat "?query=" (url-hexify-string str)
			   "&filter=" (url-hexify-string type))))
    (url-retrieve (concat fb-url arg-stuff)
		  (lambda (status) (switch-to-buffer (current-buffer))))))

(defun my-url-http-post (url args)
  "Send ARGS to URL as a POST request."
  (let ((url-request-method "POST")
	(url-request-extra-headers
	 '(("Content-Type" . "application/x-www-form-urlencoded")))
	(url-request-data
	 (mapconcat (lambda (arg)
		      (concat (url-hexify-string (car arg))
			      "="
			      (url-hexify-string (cdr arg))))
		    args
		    "&")))
    ;; if you want, replace `my-switch-to-url-buffer' with `my-kill-url-buffer'
    (url-retrieve url 'my-switch-to-url-buffer)))

(defun my-kill-url-buffer (status)
  "Kill the buffer returned by `url-retrieve'."
  (kill-buffer (current-buffer)))

(defun my-switch-to-url-buffer (status)
  "Switch to the buffer returned by `url-retreive'.
    The buffer contains the raw HTTP response sent by the server."
  (switch-to-buffer (current-buffer)))

(my-url-http-post "https://api-ssl.bitly.com" '(("GET" . "1") ("text" . "/v3/highvalue?access_token=ACCESS_TOKEN&limit=2")))

(request
 "http://search.twitter.com/search.json"
 :params '((q . "emacs awesome"))
 :parser 'json-read
 :success (function*
           (lambda (&key data &allow-other-keys)
             (let* ((tweet (elt (assoc-default 'results data) 0))
                    (text (assoc-default 'text tweet))
                    (user (assoc-default 'from_user_name tweet)))
               (message "%s says %s" user text)))))
