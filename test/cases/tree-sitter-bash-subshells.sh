(
  ./start-server --port=80
) &

time ( cd tests && sh run-tests.sh )

--------------------------------------------------------------------------------

(program
  (subshell
    (command
      (command_name
        (word))
      (word)))
  (command
    (command_name
      (word))
    (subshell
      (list
        (command
          (command_name
            (word))
          (word))
        (command
          (command_name
            (word))
          (word))))))


do_something() {
  echo ok
}

run_subshell_command() (
  true
)

run_test_command() [[ -e foo ]]

function do_something_else() {
  a | xargs -I{} find xml/{} -type f
}

function do_yet_another_thing {
  echo ok
} 2>&1

do_nothing() { return 0; }

foo::bar() {
  echo what
}

foo::baz() {
  echo how
}

assert()
  if ! $1; then
    return 1
  fi

--------------------------------------------------------------------------------

(program
  (function_definition
    (word)
    (compound_statement
      (command
        (command_name
          (word))
        (word))))
  (function_definition
    (word)
    (subshell
      (command
        (command_name
          (word)))))
  (function_definition
    (word)
    (test_command
      (unary_expression
        (test_operator)
        (word))))
  (function_definition
    (word)
    (compound_statement
      (pipeline
        (command
          (command_name
            (word)))
        (command
          (command_name
            (word))
          (concatenation
            (word)
            (word)
            (word))
          (word)
          (concatenation
            (word)
            (word)
            (word))
          (word)
          (word)))))
  (function_definition
    (word)
    (compound_statement
      (command
        (command_name
          (word))
        (word)))
    (file_redirect
      (file_descriptor)
      (number)))
  (function_definition
    (word)
    (compound_statement
      (command
        (command_name
          (word))
        (number))))
  (function_definition
    (word)
    (compound_statement
      (command
        (command_name
          (word))
        (word))))
  (function_definition
    (word)
    (compound_statement
      (command
        (command_name
          (word))
        (word))))
  (function_definition
    (word)
    (if_statement
      (negated_command
        (command
          (command_name
            (simple_expansion
              (variable_name)))))
      (command
        (command_name
          (word))
        (number)))))


declare var1
typeset -i -r var2=42 var3=10

--------------------------------------------------------------------------------

(program
  (declaration_command
    (variable_name))
  (declaration_command
    (word)
    (word)
    (variable_assignment
      (variable_name)
      (number))
    (variable_assignment
      (variable_name)
      (number))))


readonly var1
readonly var2=42

--------------------------------------------------------------------------------

(program
  (declaration_command
    (variable_name))
  (declaration_command
    (variable_assignment
      (variable_name)
      (number))))


local a=42 b
local -r c
local var=word1\ word2

--------------------------------------------------------------------------------

(program
  (declaration_command
    (variable_assignment
      (variable_name)
      (number))
    (variable_name))
  (declaration_command
    (word)
    (variable_name))
  (declaration_command
    (variable_assignment
      (variable_name)
      (word))))


export PATH
export FOOBAR PATH="$PATH:/usr/foobar/bin"
export $FOO:$BAR

--------------------------------------------------------------------------------

(program
  (declaration_command
    (variable_name))
  (declaration_command
    (variable_name)
    (variable_assignment
      (variable_name)
      (string
        (simple_expansion
          (variable_name))
        (string_content))))
  (declaration_command
    (concatenation
      (simple_expansion
        (variable_name))
      (word)
      (simple_expansion
        (variable_name)))))


_path=$(
  while statement; do
    cd ".."
  done;
  echo $PWD
)

--------------------------------------------------------------------------------

(program
  (variable_assignment
    (variable_name)
    (command_substitution
      (while_statement
        (command
          (command_name
            (word)))
        (do_group
          (command
            (command_name
              (word))
            (string
              (string_content)))))
      (command
        (command_name
          (word))
        (simple_expansion
          (variable_name))))))


$(eval echo $`echo ${foo}`)

