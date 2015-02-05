Swap two files with bash
========================

Swap two files via a 3rd file in the current directory.
Handle error cases.

Works as a standalone executable and an insourcable bash script.

## Tests
Test are written in bash too in a mini toy DSL resembling rspec.
They can be run lazily with `rake` (shows the old test output if the source hasn't changed)  and eagerly with `spec/swapf_spec.sh`.
