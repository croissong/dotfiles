(defvar *my-keymap* (make-keymap "my-map"))
(define-key *my-keymap*
    "M-d" 'switch-buffer
    "M-q" 'delete-buffer
    "C-q" 'delete-current-buffer
    "C-ö" 'switch-buffer-previous
    "C-#" 'switch-buffer-next
    "M-ö" 'nyxt/web-mode:history-backwards
    "M-#" 'nyxt/web-mode:history-forwards
    "C-M-d" 'set-url-new-buffer
    "C-d" 'set-url

    "C-e" 'set-url-from-bookmark
    "C-M-e e" 'bookmark-current-page

    "C-s" 'nyxt/web-mode:search-buffer
    "C-M-s" 'nyxt/web-mode:remove-search-hints)

(define-mode my-mode ()
  "Dummy mode for the custom key bindings in `*my-keymap*'."
  ((keymap-scheme (keymap:make-scheme
                   scheme:emacs *my-keymap*))))


;; (define-configuration buffer
;;     ((default-modes (append '() %slot-default))))
(define-configuration (buffer web-buffer)
    ((default-modes (append '(emacs-mode my-mode blocker-mode) %slot-default))))



(defvar *my-prompt-keymap* (make-keymap "my-prompt-map"))
(define-key *my-prompt-keymap*
    "M-ä" 'nyxt/prompt-buffer-mode:select-next
    "M-ü" 'nyxt/prompt-buffer-mode:select-previous)
(define-mode my-prompt-mode ()
  "Dummy mode for the custom key bindings in `*my-keymap*'."
  ((keymap-scheme (keymap:make-scheme
                   scheme:cua *my-prompt-keymap*))))

(define-configuration (prompt-buffer)
    ((default-modes (append '(my-prompt-mode) %slot-default))))



(define-command play-video-in-current-page (&optional (buffer (current-buffer)))
  "Play video in the currently open buffer."
  (uiop:run-program (list "mpv" (object-string (url buffer)))))


(define-configuration nyxt/proxy-mode:proxy-mode
  ((nyxt/proxy-mode:proxy (make-instance 'proxy
                                         :server-address (quri:uri "http://localhost:8118")
                                         :proxied-downloads-p t))))
