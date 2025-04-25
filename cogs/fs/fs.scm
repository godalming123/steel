(provide walk-files
         file->string)

(define (for-each func lst)
  (if (null? lst)
      void
      (begin
        (func (car lst))
        (when (null? lst)
          (return! void))
        (for-each func (cdr lst)))))

(define (file->string path)
  (let ([file (open-input-file path)]) (read-port-to-string file)))

;; Walk the file system, applying a function to each file found
(define/contract (walk-files path func)
  (->/c string? (->/c string? any/c) any/c)
  (cond
    [(is-file? path) (func path)]
    [(is-dir? path) (for-each (lambda (x) (walk-files x func)) (read-dir path))]
    [else void]))

; (define (consume-iter iter)
;   (define next (read-dir-iter-next! iter))
;   (when next
;     (if (read-dir-entry-is-dir? next)
;         (begin
;           (consume-iter (read-dir-iter (read-dir-entry-path next)))
;           (consume-iter iter))

;         (begin
;           (vector-push! files (read-dir-entry-path next))
;           (consume-iter iter)))))

; (define (walk cr)
;   (consume-iter (read-dir-iter cr)))
