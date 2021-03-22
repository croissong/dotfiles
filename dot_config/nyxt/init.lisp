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
    "C-d" 'set-url)

(defvar *my-minibuffer-keymap* (make-keymap "my-minibuffer-map"))

(define-mode my-mode ()
  "Dummy mode for the custom key bindings in `*my-keymap*'."
  ((keymap-scheme (keymap:make-scheme
                   scheme:emacs *my-keymap*))))


;; (define-configuration buffer
;;     ((default-modes (append '() %slot-default))))
(define-configuration (buffer web-buffer)
    ((default-modes (append '(emacs-mode my-mode blocker-mode) %slot-default))))




(define-key *my-minibuffer-keymap*
    "M-ä" 'nyxt/minibuffer-mode:select-next
    "M-ü" 'nyxt/minibuffer-mode:select-previous)


(define-mode my-minibuffer-mode ()
  "Dummy mode for the custom key bindings in `*my-keymap*'."
  ((keymap-scheme (keymap:make-scheme
                   scheme:cua *my-minibuffer-keymap*))))

(define-configuration (minibuffer)
    ((default-modes (append '(my-minibuffer-mode) %slot-default))))
