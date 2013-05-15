Rpn Calculator simplified version
=================================

A first simple implementation.

Please note, that once that a new operator is added the StackMachine could be easily refactored
to take from the constructor the list of operators. For now, it is all on the same file for simplicity.

I'm not yet sure about the simil monkey patching (add pop! method) of
the stack even if in this case it corrersponds to a clear requirment
specification. I'll check this again in a second moment. 

Refactor notes: 
 - refactor code and check for binary/unary/etc operator concept (e.g.: ->(op, lh, rh) { lh.send(op, rh) } )

 
To be checked also: overflow check, taking in consideration the requirements for 12-bit unsigned integers.

