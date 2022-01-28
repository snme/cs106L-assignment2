#!/usr/bin/python3

# Mastery Check-in Quiz Framework built by Sathya Edamadaka for 106L Interview
# This script runs one or more tests as indicated in the file "test_cases", and
# prints out any information about any test failures. Heavily inspired by the CS111
# autograder, but fundamentally different in usage and structure.
# Usage:
# autograder [test_case_file]
# If test_case_file is provided, it name a file containing test case
# descriptions; otherwise information is read from the file "test_cases."
#
# Format of test cases file: each line is a single command giving a bash command
# to invoke. I've written it this way in order to be able to reuse this autograder
# file across mastery check-ins! In a real course, I'd love to implement this with gradescope
# or in C++ by importing the exercise functions directly from exercises.cpp (though the latter
# approach would require unique test case structure for each check-in.

import locale
import os
import subprocess
import sys

# compile both files with g++.
subprocess.run(["sh", "-c", "cd build; ./test.sh; cd ..; ./build/test;"], capture_output=False,
                timeout=5, encoding=locale.getpreferredencoding())
subprocess.run(["sh", "-c", "g++ -std=c++11 exercises.cpp -o exercises"], capture_output=False,
                timeout=5, encoding=locale.getpreferredencoding())

if len(sys.argv) == 2:
  f = open(sys.argv[2], newline='\n')
elif len(sys.argv) == 1:
  f = open("test_cases", newline='\n')
else:
    print("Usage: autograder [test_case_file]")
    sys.exit(1)

failures = 0
n_tests = 0

while True:
    # Skip blank lines and read command
    while True:
        command = f.readline()
        if not command:
            break
        if command[0] == '#':
            continue
        command = command.rstrip()
        if command:
            break
    if not command:
        break

    # Run the command (with a time limit).
    print('Running test:', command)
    solution_command = command.replace('exercises', 'solution')

    try:
        student_result = subprocess.run(["sh", "-c", command], capture_output=True,
                timeout=10, encoding=locale.getpreferredencoding())
        solution_result = subprocess.run(["sh", "-c", solution_command], capture_output=True,
                timeout=10, encoding=locale.getpreferredencoding())
    except subprocess.TimeoutExpired as e:
        print("Error: '%s' took too long" % (command))
        continue

    # Parse and check the results.
    if student_result.stderr != solution_result.stderr:
        print(f"Error: incorrect error output; expected output: \n------------------\n{solution_result.stderr}",
                end="")
        print("------------------\nbut actual output was")
        print(f"------------------\n{student_result.stderr}", end="")
        print("------------------")

    student_output = "".join(student_result.stdout.split('\r'))
    solution_output = "".join(solution_result.stdout.split('\r'))
    if (student_output != solution_output):
        failures += 1
        print(f"Error: expected output\n------------------\n{solution_output}",
                end="")
        print("------------------\nbut actual output was")
        print(f"------------------\n{student_output}", end="")
        print("------------------")
    n_tests += 1

if failures:
    print(f"{failures} tests failed out of {n_tests} tests.")
else:
    print(f"All {n_tests} tests passed!")

