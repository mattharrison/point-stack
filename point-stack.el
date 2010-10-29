;; -- POINT STACK -----------------------------------------------------------------------
;; based on http://www.emacswiki.org/emacs/JohnConnors
;; enhanced with forward-stack

(defvar point-stack-stack nil)
;; after you pop put it on the forward stack
(defvar point-stack-forward-stack nil)

(defun point-stack-push ()
  "Push current location and buffer info onto stack."
  (interactive)
  (message "Location marked.")
  (setq point-stack-stack (cons (list (current-buffer) (point)) point-stack-stack)))

(defun point-stack-pop ()
  "Pop a location off the stack and move to buffer"
  (interactive)
  (if (null point-stack-stack)
      (message "Stack is empty.")
    (setq point-stack-forward-stack (cons (list (current-buffer) (point)) point-stack-forward-stack))
    (switch-to-buffer (caar point-stack-stack))
    (goto-char (cadar point-stack-stack))
    (setq point-stack-stack (cdr point-stack-stack))))

(defun point-stack-forward-stack-pop ()
  "Pop a location off the stack and move to buffer"
  (interactive)
  (if (null point-stack-forward-stack)
      (message "forward Stack is empty.")
    (setq point-stack-stack (cons (list (current-buffer) (point)) point-stack-stack))
    (switch-to-buffer (caar point-stack-forward-stack))
    (goto-char (cadar point-stack-forward-stack))
    (setq point-stack-forward-stack (cdr point-stack-forward-stack))))


(provide 'point-stack)
