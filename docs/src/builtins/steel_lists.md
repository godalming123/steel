# steel/lists
Lists in Steel have an interface that matches those of classic schemes or lisps.
At face value, they appear to be implemented as cons cells - however, under the hood
they are actually implemented as unrolled linked lists.

This means that for most practical purposes, interaction with lists is the same.
That being said, there are no improper lists, meaning, pairs are actually just lists of two elements.

Indexing into a list also takes O(n/64) - which means you'll get constant time indexing on small lists.

```scheme
(list 10 20 30 40) ;; => '(10 20 30 40)
```
### **append**
Appends the given lists together. If provided with no lists, will return the empty list.

(append lst ...)

lst : list?

#### Examples
```scheme
> (append (list 1 2) (list 3 4)) ;; => '(1 2 3 4)
> (append) ;; => '()
```
### **apply**
Applies the given `function` with arguments as the contents of the `list`.

(apply function lst) -> any?

* function : function?
* list: list?

#### Examples
```scheme
> (apply + (list 1 2 3 4)) ;; => 10
> (apply list (list 1 2 3 4)) ;; => '(1 2 3 4)
```
### **car**
Returns the first element of the list l.

(car l) -> any/c

* l : list?

#### Examples

```scheme
> (car '(1 2)) ;; => 1
> (car (cons 2 3)) ;; => 2
```
### **cdr**
Returns the rest of the list. Will raise an error if the list is empty.

(cdr l) -> list?

* l : list?

#### Examples
```scheme
> (cdr (list 10 20 30)) ;; => '(20 30)
> (cdr (list 10)) ;; => '()
> (cdr '())
error[E11]: Generic
┌─ :1:2
│
1 │ (cdr '())
│  ^^^ cdr expects a non empty list
```
### **cons**
Returns a newly allocated list whose first element is `a` and second element is `d`.

(cons a d) -> list?

* a : any/c
* d : any/c

#### Examples
```scheme
> (cons 1 2) ;; => '(1 . 2)
> (cons 1 '()) ;; => '(1)
```
### **empty?**
Checks if the list is empty

(empty? lst) -> bool?

* lst: list?

#### Examples

```scheme
> (empty? (list 1 2 3 4 5)) ;; => #false
> (empty? '()) ;; => #true
```
### **first**
Returns the first element of the list l.

(first l) -> any/c

* l : list?

#### Examples

```scheme
> (first '(1 2)) ;; => 1
> (first (cons 2 3)) ;; => 2
```
### **last**
Returns the last element in the list. Takes time proportional to the length of the list.

(last l) -> any/c

* l : list?

#### Examples
```scheme
> (list (list 1 2 3 4)) ;; => 4
```
### **length**
Returns the length of the list.

(length l) -> int?

* l : list?

#### Examples

```scheme
> (length (list 10 20 30)) ;; => 3
```
### **list**
Returns a newly allocated list containing the vs as its elements.

(list v ...) -> list?

* v : any/c

#### Examples

```scheme
> (list 1 2 3 4 5) ;; => '(1 2 3 4 5)
> (list (list 1 2) (list 3 4)) ;; => '((1 2) (3 4))
```
### **list->string**
Convert a list of charecters to a string.

(list->string lst) -> string?

* lst : (listof char?)

#### Examples
```scheme
(list->string '(#\a #\b #\c)) ;; => "abc"
```
### **list-drop**
Remove a certain number of elements (`n`) from the front of `lst`.

(list-drop lst n) -> any/c

* lst : list?
* n : int?

#### Examples
```scheme
> (list-drop '(1 2 3 4 5) 2) ;; => '(3 4 5)
> (list-drop '() 3) ;; => '()
```
### **list-ref**
Returns the value located at the given index. Will raise an error if you try to index out of bounds.

Note: Runs in time proportional to the length of the list, however lists in Steel are implemented in such a fashion that the
time complexity is O(n/64). Meaning, for small lists this can be constant.

(list-ref lst index) -> list?

* lst : list?
* index : (and/c int? positive?)

#### Examples
```scheme
> (list-ref (list 1 2 3 4) 2) ;; => 3
> (list-ref (range 0 100) 42) ;; => 42"
> (list-ref (list 1 2 3 4) 10)
error[E11]: Generic
┌─ :1:2
│
1 │ (list-ref (list 1 2 3 4) 10)
│  ^^^^^^^^ out of bounds index in list-ref - list length: 4, index: 10
```
### **list-tail**
Same as `list-drop`, except raise an error if `n` is greater than the length of `lst`.

(list-tail lst n) -> any/c

* lst : list?
* n : int?

#### Examples
```scheme
> (list-tail '(1 2 3 4 5) 2) ;; => '(3 4 5)
> (list-tail '() 3)
error[E11]: Generic
┌─ :1:2
│
1 │ (list-tail '() 3)
│  ^^^^^^^^^ list-tail expects at least 3
elements in the list, found: 0
```
### **pair?**
Checks if the given value can be treated as a pair.

(pair? any/c) -> bool?

#### Examples

```scheme
> (pair? '(10 20)) ;; => #true
> (pair? '(10)) ;; => #true
> (pair? '()) ;; => #false
```
### **range**
Returns a newly allocated list of the elements in the range [n, m) or [0, m) when n is not given.

(range m)   -> (listof int?)
(range n m) -> (listof int?)

* n : int?
* m : int?

```scheme
> (range 4) ;; => '(0 1 2 3)
> (range 4 10) ;; => '(4 5 6 7 8 9)
```
### **rest**
Returns the rest of the list. Will raise an error if the list is empty.

(rest l) -> list?

* l : list?

#### Examples
```scheme
> (rest (list 10 20 30)) ;; => '(20 30)
> (rest (list 10)) ;; => '()
> (rest '() )
error[E11]: Generic
┌─ :1:2
│
1 │ (rest '())
│  ^^^^ rest expects a non empty list
```
### **reverse**
Returns a list that has the same elements as `lst`, but in reverse order.
This function takes time proportional to the length of `lst`.

(reverse lst) -> list?

* lst : list?

#### Examples
```scheme
> (reverse (list 1 2 3 4)) ;; '(4 3 2 1)
```
### **second**
Get the second element of the list. Raises an error if the list does not have an element in the second position.

(second l) -> any/c

* l : list?

#### Examples

```scheme
> (second '(1 2 3)) ;; => 2
> (second '())
error[E11]: Generic
┌─ :1:2
│
1 │ (second '())
│  ^^^^^^ second: index out of bounds - list did not have an element in the second position: []
```
### **take**
Returns the first n elements of the list l as a new list.

(take l n) -> list?

* l : list?
* n : (and/c positive? int?)

#### Examples

```scheme
> (take '(1 2 3 4) 2) ;; => '(0 1)
> (take (range 0 10) 4) ;; => '(0 1 2 3)
```
### **third**
Get the third element of the list. Raises an error if the list does not have an element in the third position.

(third l) -> any/c

* l : list?

#### Examples
```scheme
> (third '(1 2 3)) ;; => 3
> (third '())
error[E11]: Generic
┌─ :1:2
│
1 │ (third '())
│  ^^^^^^ third: index out of bounds - list did not have an element in the second position: []
```
### **cdr-null?**
### **list->vector**
### **list-chunks**
### **plist-get**
### **plist-get-kwarg**
### **plist-get-positional-arg**
### **plist-get-positional-arg-list**
### **plist-try-get**
### **plist-try-get-positional-arg**
### **plist-validate-args**
### **push-back**
### **try-list-ref**
